---
layout: post
title:  "CSS Grid and Feature Queries for Microsoft Edge"
date:   2017-05-10 00:00:00 -0500
categories: front-end
snippet: "How to implement CSS Grid with cross-browser support right meow."
---

The default layout grid features a sidebar of 300px wide, with a flexible main area. The gutter between them is 20px. On screens up to 991px, the grid collapses.

{% highlight html %}
<div class="layout-grid">
 <div class="layout-grid-item"><p>The man who last claimed the Power Of Gold wished for this world. It reflects his heart. Yes, I came here because of greed for the Golden Power, and look what happened to me... Well, my mind is getting hazy... Please let me hear the sound of the flute one last time. You are perhaps the last one to carry on the blood-line of the Knights... It is ironic that the last one in the line has the potential to become the Hero of legend. If a person who has an evil heart gets the Triforce, a Hero is destined to appear... and he alone must face the person who began the Great Cataclysm. If the evil one destroys the Hero, nothing can save the world from his wicked reign. Only a person of the Knights Of Hyrule, who protected the royalty of Hylia, can become the Hero... May the way of the Hero lead to the Triforce. </p><p>After Agahnim took over, everyone began to act strangely. I suppose it's only a matter of time before I'm affected, too. But what a mischievous thing to leave lying around... The Power Of Gold... Triforce... </p><p>I underestimated that boy. Watch Out! What's your name? ...Link... Strange, it sounds... familiar. Okay, Link... The flow of time is always cruel... its speed seems different for each person, but no one can change it... A thing that does not change with time is a memory of younger days... The Great Deku Tree wants to talk to you! </p>
 </div>
 <div class="layout-grid-item">
     <img src="http://spaceholder.cc/300x200" alt="Random image of space" />
 </div>
</div>
{% endhighlight %}


{% highlight sass %}
.layout-grid

    +bp(large-up)
        overflow: auto
        width: 100%

        & > .layout-grid-item
            float: left
            &:first-of-type
                width: calc(100% - 320px)

            &:nth-of-type(2)
                margin-left: 1em
                width: 300px

        // feature query for browsers that support grid.
        // Microsoft Edge will pick up this query, maybe because postCSS?
        @supports(display: grid)
            display: grid
            grid-template-columns: 1fr 300px
            grid-gap: 20px

            & > .layout-grid-item
                width: auto !important

        // Override for Microsoft Edge.
        @supports(display: -ms-grid)
            display: block
            & > .layout-grid-item
                float: left
                &:first-of-type
                    width: calc(100% - 320px) !important

                &:nth-of-type(2)
                    margin-left: 1em
                    width: 300px
{% endhighlight %}
