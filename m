Return-Path: <me@tobin.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=
	mime-version:message-id:in-reply-to:references:date:from:to:cc
	:subject:content-type; s=fm3; bh=7JuLeiITaoq/ZdIt1bv+Coe9tJr2OvJ
	fGTrs9RPOvKA=; b=QRaNsKU2yIFWnd/ZcyvstDBPG7JdMj/uZvV58FYXS1/qgZ/
	pFjkIspYzXP0CJ4/47U+xJZMPEZKUS2q1F4bfrTEgfx9ceAZDLGqMq8WVNho4GZR
	2AH336rmuPHe1/EapseaOMx2jk7lQWGdp/Ia8awBScSIaknC7pWAFbuwm6fV5JOY
	oi9NYWd6ZQ0WaUHhI6r+626ZTXR5asnCJofbp8RN7xs5xsiBuVfQjxv7ywvVKVTj
	7+ogtpeyqUQaIazvZCAf3u1HfhQkGlVvFa2y48yPO1+S9Zn84JwJoViRyIB42aZW
	y3D7MqqyojeuNe/xSSw5M7d33wqBLEdAr4KEOPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7JuLei
	ITaoq/ZdIt1bv+Coe9tJr2OvJfGTrs9RPOvKA=; b=fER8xRcxPuMQVq7d781NQf
	7qk5hbsWy87SFgiYTTjqKaiSR80OiLs4BGjRXiYX/lTE4JowdVdrFVHrbjw+m1iy
	GEwzSWoaUGqWmXziyTSBmKcu0HGx4Z6gd2CPPL2iXgNdYVG44AmiyXhrvndfoLEp
	dimkft4Mkv5PKoB4v0K4ynQyAx8W0Y3tahbjxm0iUvwo6q9ihqikIcVmB/stxBcE
	iBIrPDBRV/jelcvZZx2g3C7ZFFRIOHbNod1fuyHUH9p3/6IcJE8wFgeg2Iz1cMYJ
	2mduFcXfHw1bYf1AnBIshWennh/4tFzQ/UygESH9QF4duYmnxlAhXFS/rp4Vec1A
	==
Mime-Version: 1.0
Message-Id: <8446e80f-49e5-4792-900f-49aa61165644@www.fastmail.com>
In-Reply-To: <20190509203501.310a477c@hermes.lan>
References: <20190510025212.10109-1-tobin@kernel.org>
	<20190510025702.GA10709@eros.localdomain>
	<20190509203501.310a477c@hermes.lan>
Date: Thu, 09 May 2019 23:59:01 -0400
From: "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v2] bridge: Fix error path for
	kobject_init_and_add()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>, "Tobin C. Harding" <tobin@kernel.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Tyler Hicks <tyhicks@canonical.com>, Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>



On Fri, May 10, 2019, at 13:35, Stephen Hemminger wrote:
> On Fri, 10 May 2019 12:57:02 +1000
> "Tobin C. Harding" <tobin@kernel.org> wrote:
> 
> > On Fri, May 10, 2019 at 12:52:12PM +1000, Tobin C. Harding wrote:
> > 
> > Please ignore - I forgot about netdev procedure and the merge window.
> > My bad.
> > 
> > Will re-send when you are open.
> > 
> > thanks,
> > Tobin.
> 
> That only applies to new features,  bug fixes are allowed all the time.
> Also please dont send networking stuff to the greater linux-kernel mailing list.

Oh cool, thanks.
