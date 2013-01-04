Return-Path: <roszenrami@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=btYHVS8MZnYI2ujs0FAWDXVKFShNHuGd/O6Hkefk9+A=;
	b=C3M1TNbTFObMo0aiFD0pMooF0nuZn3m7jYUgktN/c6/cA/S2zZR/ZhKkvyHsDFXCBy
	PhBZPlAYTOior2B2YRDmqzi2iBuPBiKNj74YVx8cBnKTXfILt4hru2muqiG3ORm39YWH
	dKtAXwHn9+2nI8Lpt4CuUSLJR+1OK3IcfgQDOGBoMZZ3U+1yOFsTrFQdc2SAtXqS9V/q
	yZ0bvYu1FC5ClX7GlRaVQII6x/+hV2BLk3lJDC7SHBLsgkrm1P3KN0L3lSXFuxvd0A6D
	spHWeIAU5rCCBSz2sxllAix5mjPI3nfI95zpnhZdMn7pNe3XzGychB2I6ZGK863e/+H4
	GObw==
MIME-Version: 1.0
In-Reply-To: <20130104112716.596f9085@nehalam.linuxnetplumber.net>
References: <20130104152814.3a3cf74bdec76cea09d3e134@canb.auug.org.au>
	<50E72977.7030605@infradead.org>
	<20130104112716.596f9085@nehalam.linuxnetplumber.net>
Message-ID: <CAKoUArn=6UMjcKC6rnUmpkXFxQvSWnc=1N44iZFPKn80aMBNvA@mail.gmail.com>
From: Rami Rosen <roszenrami@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Bridge] linux-next: Tree for Jan 4 (net/bridge)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 04 Jan 2013 19:54:58 -0000
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Randy Dunlap <rdunlap@infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org

Hi,

The cause of the problem in net tree (but **not** net-next tree) is:
commit 3ec8e9f085bcaef0de1077f555c2c5102c223390
"bridge: Correctly unregister MDB rtnetlink handlers"
and it is fixed by a patch from me, for the net tree, from yesterday.

see:
http://www.spinics.net/lists/netdev/msg221168.html

probably this patch, which was applied to net,  was not pulled yet.

I believe that since the commit above was not to net-next, this
problem is not observed in your tree.

Rami Rosen
http://ramirose.wix.com/ramirosen

On Fri, Jan 4, 2013 at 9:27 PM, Stephen Hemminger <shemminger@vyatta.com> wrote:
> On Fri, 04 Jan 2013 11:11:51 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
>
>> On 01/03/13 20:28, Stephen Rothwell wrote:
>> > Hi all,
>> >
>> > Changes since 20130103:
>> >
>>
>> on i386 and x86_64:
>>
>>   CC      net/bridge/br_netlink.o
>> net/bridge/br_netlink.c: In function 'br_netlink_init':
>> net/bridge/br_netlink.c:307:2: error: implicit declaration of function 'br_mdb_init' [-Werror=implicit-function-declaration]
>> net/bridge/br_netlink.c:314:2: error: implicit declaration of function 'br_mdb_uninit' [-Werror=implicit-function-declaration]
>> cc1: some warnings being treated as errors
>> make[3]: *** [net/bridge/br_netlink.o] Error 1
>>
>>
>> Full randconfig file is attached.
>>
>>
>
> Problem not observed with current net-next and your configuration.
> Probably already fixed.
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
