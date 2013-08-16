window.App = Ember.Application.create();

App.Router.map(function() {
  this.resource('user', function() {
    this.route('home');
    this.route('timeline', { path: '/timelines/:screen_name' });
  })
});

App.IndexRoute = Ember.Route.extend({
  redirect: function() {
    return this.transitionTo('user.home');
  }
});

App.UserRoute = Ember.Route.extend({
  model: function() {
    return Ember.$.getJSON('/user.json');
  }
});

App.UserHomeRoute = Ember.Route.extend({
  model: function() {
    return Ember.$.getJSON('/home.json');
  }
});

App.UserTimelineRoute = Ember.Route.extend({
  model: function(params) {
    return Ember.$.getJSON('/timelines/' + params.screen_name + '.json');
  }
});

App.TweetController = Ember.ObjectController.extend({
  biggerProfileImage: function() {
    return this.get('user.profile_image_url').replace('normal', 'bigger');
  }.property('user.profile_image_url')
});

Ember.Handlebars.helper('html', function(tweet, options) {
  var replaceUrls = function(text, urlData) {
    var start = urlData.indices[0];
    var end   = urlData.indices[1];
    return text.slice(0, start) + '<a href="' + urlData.expanded_url + '">' + urlData.display_url + '</a>' + text.slice(end);
  }

  // Essentially there is no way to extract urls from RTs from the data Twitter provides
  // so we might as well go simply matching urls in the text
  var text = tweet.get('text').replace(/\n/g, '<br />');
  var urlEntities = tweet.get('entities.urls');

  var withUrls = text;
  urlEntities.forEach(function(urlData) {
    //FIXME: This breaks when there are multiple urls
    withUrls = replaceUrls(text, urlData);
  });

  var mediaEntities = tweet.get('entities.media') || [];
  mediaEntities.forEach(function(urlData) {
    withUrls = replaceUrls(withUrls, urlData);
  });

  return new Handlebars.SafeString(withUrls);
});

App.TimelineLinkView = Ember.View.extend({
  tagName: 'span',
  layout: Ember.Handlebars.compile('<a {{bindAttr href=view.link}}>{{yield}}</a>'),

  link: function() {
    return "#/user/timelines/" + this.get('name');
  }.property('name')
});
