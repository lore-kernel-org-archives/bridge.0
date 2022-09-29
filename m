Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 91D5C40147
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E188F40117
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664468532;
 bh=d2xbFWd6cZFHqRqtchaW5YtreTtOFcfhK6VaJhknpbI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=n0wLICpr9rwLDoO4I22Q+j9GYGdUKtx6O4WAI2LoMiZB3FDSAWURYHUfaUCVoy0FM
 qYyRxJgC0jSvph0Coo/utPsy68jMOH4DGqPFWjRqQEKttA/d/0ZrktDUcVfwwNuHYL
 7S0HoBNZHiImbcIfMeTZSAaIn1zhtANzQbzqt32J/JeYD3OMUq74UVbliF+CfVlu/p
 J0/ACe8PO1rnEPHBK1ESN38tRjPVVor7iVryP5kv1sA7xGmVWQ0mD3oN4aWaqOEzHm
 9PdQWpxoqQyzL/n52vrIBKCwHTD8pcJQesLiDsZ8geoyB2WeoZD2mTUT3adNUZloCX
 4w2/AXVJNLemw==
Date: Thu, 29 Sep 2022 09:22:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220929092210.0423e96d@kernel.org>
In-Reply-To: <6811b44516cf8bf37678bab23bca80ba@kapio-technology.com>
References: <20220928174904.117131-1-netdev@kapio-technology.com>
 <20220929091143.468546f2@kernel.org>
 <6811b44516cf8bf37678bab23bca80ba@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v6 net-next 9/9] selftests: forwarding: add
 test of MAC-Auth Bypass to locked port tests
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Florent Fourcot <florent.fourcot@wifirst.fr>, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Thu, 29 Sep 2022 18:17:40 +0200 netdev@kapio-technology.com wrote:
> > If you were trying to repost just the broken patches - that's not gonna
> > work :(  
> 
> Sorry, I do not understand what 'broken' patches you are referring to?
> 
> I think that the locked port tests should be working?

Ignore it then. v6 does not build, see my other reply.
