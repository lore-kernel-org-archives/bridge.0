Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=xM/5hg73CAO5nDlUiWnC06sBYRoGEVNZps4ThjEK80g=;
 b=SM1DxTrgTQmc/EbSc5o/ZKIU4t62Dau5mNSp1bsk7iNoKcDtfvVrYZ+dAjdNqwDI4x
 nzZKOWr7tfhFVPyHPSlQURghDVLrbMfgs43M7gPs+0Uio3Cpz2RTkontu83Eb5mqdD3x
 OfK85T0Upyl6y/12E5n1WE0FwhaPhAS68b7KKXmpmZfkRI286LwpC3WlK4agL7LGhxYo
 xeYHLXxFaBRst7J9z64xRfBl0XEtWNcH9VGL5vGE/T6AMbtDcdvXM8PAmExa+LN6S9qr
 5RKsTcMQqfMeaucp4c3MObUiIn8thVESL/Uxh5Vp5kfczH7zxWIx/+QUw3kXePwqCkPM
 meGQ==
From: Joachim Wiberg <troglobit@gmail.com>
In-Reply-To: <458e3729-0bf0-8c45-9e45-352da76eaeb6@blackwall.org>
References: <20210719170637.435541-1-razor@blackwall.org>
 <875yw1qv9a.fsf@gmail.com>
 <458e3729-0bf0-8c45-9e45-352da76eaeb6@blackwall.org>
Date: Fri, 20 Aug 2021 08:26:09 +0200
Message-ID: <871r6or5ry.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 00/15] net: bridge: multicast: add
	vlan support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, Nikolay Aleksandrov <nikolay@nvidia.com>, roopa@nvidia.com

On Thu, Aug 19, 2021 at 19:22, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> On 19/08/2021 19:01, Joachim Wiberg wrote:
>> On Mon, Jul 19, 2021 at 20:06, Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>> From: Nikolay Aleksandrov <nikolay@nvidia.com>
>> Curious, are you planning querier per-vlan, including use-ifaddr support
>> as well?  In our in-house hack, which I posted a few years ago, we added
>> some "dumpster diving" to inet_select_addr(), but it got rather tricky.
>> So I've been leaning towards having that in userspace instead.
> Yes, that is already supported (use-ifaddr needs attention though). In my next
> patch-set where I added the initial global vlan mcast options I added control
> for per-vlan querier with per-vlan querier elections and so on. The use-ifaddr
> needs more work though, that's why I still haven't added that option. I need
> to add the per-vlan/port router control option so we'll have mostly everything
> ready in a single release.

Wow, OK now we're talking, yeah that would be great to have in place as well!

>>> Future patch-sets which build on this one (in order):
>>>  - iproute2 support for all the new uAPIs
>> I'm very eager to try out all the new IGMP per-VLAN stuff, do you have
>> any branch of the iproute2 support available yet for testing?
> I don't have it public yet because I need to polish the support, currently
> it's very rough, enough for testing purposes for these patch-sets. :)
> I plan to work on that after I finish with the per-vlan/port router control.

Alright, I can appreciate that.  Really looking forward to this, I'll be
patiently waiting here in the wings, testing this out.

Fantastic work with this, again! :)

All the best
 /Joachim
 
