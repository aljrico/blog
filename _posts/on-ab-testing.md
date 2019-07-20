---
	layout: post
title: "On A/B Testing"
categories:
	- blog
comments: True
---


Nowadays, accurate A/B testing seems to become one of the most important tools in any modern company that intends to make data-driven decisions. And it represents maybe the most powerful implementation of the scientific method into business endevours.


# What is an A/B test good for?


A/B testing basically is a tool to compare two version of a single variable. Let's put a real example. 

{% include image_url.html src="black-decker-button-test.png" title="Button_AB_testing" width="100%" %}



That is interesting becausue in Product Development, there is a cascade of reasonable ideas that we have no clue on whether they are going to be useful or not. "Let's colour this button of *blue*. It gives more confidence", "*Orange* is more exciting, it will trigger more attention". At the end you have to decide, and it is not alway clear cut which option is going to be more profitable.

 he button it's been blue for a long time, but you are considering changing it to orange. Is it a good idea? Let's A/B test it and figure that out.


# So you want to A/B test

The way A/B testing works is that you can define a metric that you are interested in improve, and test the effect of your ideas on it. 

So you split some sample population into two groups (*A* and *B*), you give them a slight variation of your product - in our example, half of them are seeing the button in *blue*, and the other half in *orange*.

So now, what do we want to achieve? Let's say that your product is an app and what you want to improve is the average money spent by user. You want them to spend as much money as possible, don't you? Let's increase that.






A/B Testing has become most famous in medical clinical trials, and most of its discussion evolved on medical issues. But there is one discussion that I think is usually taken for granted in the industry, that we need to realized that is fundamentally different from clinical trials. And that is *time*.

Clinical trials are very rarely in a rush to finish the experiment. Yes, there is a lot of money exposed, high stakes and big risks. All of that means that wasting time is the same as losing money. But that potential loss is nothing compared to the losses derived from misguided results. So the priority is always going to be on _making sure_ the experiment is reliable, not so much on finishing as soon as possible.

In the industry there is the tendency to have these priorities inverted. The current perspective on data-driven companies is the *Agile* mentality implemented in decision making, as it is fantastically described in the popular book [The Lean Startup](https://www.amazon.co.uk/s/?ie=UTF8&keywords=the+lean+startup&index=aps&tag=googhydr-21&ref=pd_sl_72xxnortzb_e&adgrpid=54730571218&hvpone=&hvptwo=&hvadid=259093725533&hvpos=1t2&hvnetw=g&hvrand=1937859941242138832&hvqmt=e&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9045999&hvtargid=kwd-364810519397). One of the crucial characteristics of this mentality is the _Fail Often & Fail Fast_ in order to foster constant innovation. Methodology that can be extremely useful, or that can lead your project blindly to disaster if it's used as an excuse to misinterpret the results from A/B testing. Being fast is important, but being accurate is _mandatory_.

When you hear about accuracy, normally you'd think about being more precise or adding more decimals to your predictions. By _accurate_ I mean *not being wrong*. If you finish your experiment early because your Type I Error is already below 0.05, you are probably wrong. And being wrong can be extremely expensive.

In [this](http://www.evanmiller.org/how-not-to-run-an-ab-test.html) very recomended article, the author explains very thoroughly the common mistake that leads to this kind of error. And the conclusion is that you should never finish your experiments early. Even if you peek your results and see that you've already achieved statistical significance, stopping the test early can lead to disastrous misinterpretations of the results.

So you need to define a Sample Size _in advance_, and go on with the experiment until it reaches that size. And then you check the statistical significance.

But how do we know the Sample Size beforehand? By defining the minimum *effect size* that we'd wish for the experiment. It is very logical, from both an academic and traditional business mindset points of view, to define a minimum desired effect for a change before conducting the experiment. 

But now we want to be _Lean_, _Agile_. We are interested in being accurate, yes, but we are interested also in being *as fast as we can*. We want to run more experiments, to iterate and try new ideas. From this perspective, any measurable improvement is already a success, because many small improvements are marginal gains that accumulate in top of each other. After hundreds of experiments that is far more profitable than a perfectly well measured single experiment with great accuracy.

So we want to finish the experiment as early as possible, whilst still making sure that our decisions are accurately supported by well-implemented A/B tests.
