Return-Path: <noltari@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-type:content-transfer-encoding;
	bh=ZYaNvi2eYdrzCx45/ajELd7RS7c/iWsFMlfCje3Ickg=;
	b=pBL1VGTVDUIYkRvHBUJxE+JXfMF+gHCrx4t8FRYBpX925hS4xYbItGDYvQFYzAzsj2
	L9/NWlHR4arM+lfyGrs4UiqLEvOzMSgwmhDNqeLe/3zLIK0aHx4cQcmdOv3w1sxVWyds
	IXpPYWBOOahW3Vj2Seoelu51qvM3yRPGWqugP2/+3UP0L1pSBG+LDbR6rZ8WVoXuEE6y
	wXIySpyh4EFBeba7RMcWRB1dMR8LTeVo+mkB5hfUPAuc+owy/BN+JXScFHrwbZtz/IsZ
	6MMnjORdxOvWdcaa2t56xytp3EG/Ee+WzmgMRkQMoeL/M8jwiLCqLHyzv9nT2bDeXYAu
	vQEw==
References: <56A2993B.4070307@gmail.com> <20160122131046.6f141681@xeon-e3>
	<56A2AF73.2090204@gmail.com> <20160213023528.GC7093@otheros>
	<20160214115717.GA3138@otheros>
From: =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
Message-ID: <56C070F2.40906@gmail.com>
Date: Sun, 14 Feb 2016 13:20:02 +0100
MIME-Version: 1.0
In-Reply-To: <20160214115717.GA3138@otheros>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] hw csum failure introduced in linux-4.2
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux-foundation.org, davem@davemloft.net

Hi Linus,

Thanks for taking the time to look into this issue because unfortunately 
I don't have that time right now.
BTW, the error should also be reproducible on any Raspberry Pi v1 with 
ethernet.

Regards,
Álvaro.

El 14/02/2016 a las 12:57, Linus Lüssing escribió:
> Ok, was able to borrow a Raspi 2 and indeed I can reproduce the
> issue there.
>
> Reverting these patches helps:
>
> On Sat, Feb 13, 2016 at 03:35:28AM +0100, Linus Lüssing wrote:
>> c2d4fbd2163e ("bridge: fix igmpv3 / mldv2 report parsing")
>> a516993f0ac1 ("net: fix wrong skb_get() usage / crash in IGMP/MLD parsing code")
>> 9afd85c9e455 ("net: Export IGMP/MLD message validation code")
> I'm on it.

