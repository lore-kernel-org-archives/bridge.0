Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=vuU1EFjGQgOx6y8JfLq+nezIt0YmZgCEdH0SpZ/NZz8=;
	b=fBe+Y3xvjkbE88c/TFs7Q2i8UWg4Q+a0sewvGmiEZPlUUXc8iHoj20pn2iNcsqAYh4
	LnLbqBnMre/y/nOXoJKZptrbpglsJSRIDtU/BdIlMqL8yAUTZ8e4p0jSffHA3ziKkWOu
	g30oKgArvv7YFmD902eYbArR2nzqTDodt+9yYrltEAyCGuOa/wA3/PIq9Te1c3pW4Ea3
	y7tQ3KpfeO1zjPysHQWlBJrGw5yRgv905Jmt//rQJYVpeFkNYBpHK1Ldbk3AhrJILv7n
	os4V2irFr+yPEaWYEKr5waRk46rdDztHQ5Sc5C8uNQQ7cY6EX3ppdWMJxeEJXg6hiL/f
	5YDQ==
Date: Mon, 26 Nov 2018 09:39:23 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20181126093923.74c50dcb@xeon-e3>
In-Reply-To: <bc90dc53-b4fc-3725-7141-556e62f027f8@cumulusnetworks.com>
References: <20181124023422.13908-1-nikolay@cumulusnetworks.com>
	<20181124023422.13908-2-nikolay@cumulusnetworks.com>
	<20181124161041.GA24681@lunn.ch>
	<66D818AF-A45E-41B3-AC9C-90A7E607FD2D@cumulusnetworks.com>
	<20181124162541.GC24681@lunn.ch>
	<98A5C526-DBF7-40F0-9CB0-1C7AF7A5CF32@cumulusnetworks.com>
	<bc90dc53-b4fc-3725-7141-556e62f027f8@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 1/3] net: bridge: add support for
 user-controlled bool options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Andrew Lunn <andrew@lunn.ch>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, netdev@vger.kernel.org

On Sun, 25 Nov 2018 10:12:45 +0200
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> On 24/11/2018 18:46, nikolay@cumulusnetworks.com wrote:
> > On 24 November 2018 18:25:41 EET, Andrew Lunn <andrew@lunn.ch> wrote:  
> >> On Sat, Nov 24, 2018 at 06:18:33PM +0200, nikolay@cumulusnetworks.com
> >> wrote:  
> >>> On 24 November 2018 18:10:41 EET, Andrew Lunn <andrew@lunn.ch> wrote:  
> >>>>> +int br_boolopt_toggle(struct net_bridge *br, enum br_boolopt_id  
> >> opt,  
> >>>> bool on,  
> >>>>> +		      struct netlink_ext_ack *extack)
> >>>>> +{
> >>>>> +	switch (opt) {
> >>>>> +	default:
> >>>>> +		/* shouldn't be called with unsupported options */
> >>>>> +		WARN_ON(1);
> >>>>> +		break;  
> >>>>
> >>>> So you return 0 here, meaning the br_debug() lower down will not
> >>>> happen. Maybe return -EOPNOTSUPP?
> >>>>  
> >>>
> >>> No, the idea here is that some option in the future might return an  
> >> error.   
> >>> This function cannot be called with unsupported option thus the warn.  

> 

Please don't implement some part of the API until it is used (YAGNI).
If do this kind of "someday will come" design the code will end up
littered with dead ends.
