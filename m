Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 91BB9843D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6539843DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L2G/9Nt1UPxsYT32uFvEw5BhWk6FA6rHpv/vvZ1BQSE=;
 b=L7KL7Cmq5BeuUdYGMW3cAgtIcuVZg5ASkJ/IZNJWWUiJ+/Qt6gVlScz1u/W2UurieC
 StTRCMiF1gayWtat9yR1jxy03jHzqPRpY+d/GgJ1K8lmNPRqj47kEmjBivrdxwcQlJRP
 gqfaCFKJCe0cSgQC/Xx9MVQoKg98NUMWFRqSK3/+nRYCXn1Q7yrGT4PHRNV43mZeBqb1
 cVtzyuggTcE1Pu9cpikwolaS6fyiZ1HlsdnyB5HAFFtEAPY8oUGlBvmr4xSRLlq7VRIk
 7rfYUfkbEQcY9aYc3JzsWSeJh1CqZ0CXrIEVX1+mmeRiMEa2Rwrz9msL2vRPepDcIKvz
 1T1Q==
Date: Fri, 21 Oct 2022 01:52:47 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221020225247.acy4cejhcmtmf6ua@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221020130224.6ralzvteoxfdwseb@skbuf>
 <715c068915c9f07ad62d9837e70df7a1@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <715c068915c9f07ad62d9837e70df7a1@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v8 net-next 05/12] net: dsa: propagate the
 locked flag down through the DSA layer
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Florent Fourcot <florent.fourcot@wifirst.fr>, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Thu, Oct 20, 2022 at 09:43:40PM +0200, netdev@kapio-technology.com wrote:
> I guess you mean, why it differs from the inherit flag mask list?
> 
> If so it is explained in the update to v7 in 00/12.

The following is written there:

|        v7:     Remove locked port and mab flags from DSA flags
|                inherit list as it messes with the learning
|                setting and those flags are not naturally meant
|                for enheriting, but should be set explicitly.

Can you go one level deeper with the explanation? What messes with the
learning setting? Why are those brport flags not naturally meant for
inheriting?

It's pretty hard to take your patch set seriously if you don't provide
proper explanations.
