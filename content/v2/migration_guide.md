<div id="migration-guide" markdown="block">
## Freckle has a new name: Noko!

<p class="note">
Below are the steps you'll need to take to make sure your integrations and apps still work!

Want to learn more? You can read <a href="https://nokotime.com/blog/2019/03/freckle-getting-new-name-noko/">our announcement here</a>
</p>

<section markdown="block">
### What do I need to do?

Change your apps and integrations to point to:

~~~
https://api.nokotime.com/v2
~~~

If you're using [OAuth](/v2/oauth/), change your OAuth authorization flow to point to:

~~~
https://secure.nokotime.com
~~~

*Aside from the domain name change, the rest of the API will remain exactly the same.*


### What if I have questions?

If you have _any_ questions at all, please [email](mailto:support@nokotime.com) or [tweet](http://twitter.com/freckle) us! We're incredibly grateful that you use the API, and we want to make the transition as smooth as possible.
</section>
</div>
