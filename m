Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 44403610C3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED23460B96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664549526;
 bh=wAWWnDm7dRfdfL1HmqTHFE1I+5HoqUMPdvT4lPVEVoE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bJQRnCgWgZS/Y4k3DPIVn8jCZvgWNT8MnReKAQQxb9c7BvikjAFxBUbelfmcH+g/8
 BnLeyvMclzeZw9EyFesPMH5HJftJHAQyAVx3uzjeOYbWf+tsLFfVnnsfbNYO/MpRWn
 89z7zInb1EqAj4CB3WO7e0+pAAsCIxVYGhnMj97QnCAf/VAwvyt2vJZSxob/n17hD+
 +3qptHAyJuCpgRLDppuF4+PSlZYWUIUx6bspwZuCzGROyytwzBG9k/Sp508GdImeej
 GXaeifMfOoC2Tut/0wuCnBLHLJgmYvD62nyPwwIezJpkF6cqAL+Bqo2gyw4/wTgMl1
 HLtS0Q7AAdxAw==
Date: Fri, 30 Sep 2022 07:52:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220930075204.608b6351@kernel.org>
In-Reply-To: <Yzb3oNGNtq4GCS3M@shredder>
References: <20220928150256.115248-1-netdev@kapio-technology.com>
 <20220929091036.3812327f@kernel.org>
 <12587604af1ed79be4d3a1607987483a@kapio-technology.com>
 <20220929112744.27cc969b@kernel.org>
 <ab488e3d1b9d456ae96cfd84b724d939@kapio-technology.com>
 <Yzb3oNGNtq4GCS3M@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v6 net-next 0/9] Extend locked port feature
 with FDB locked flag (MAC-Auth/MAB)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, netdev@kapio-technology.com, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Fri, 30 Sep 2022 17:05:20 +0300 Ido Schimmel wrote:
> You can see build issues on patchwork:

Overall a helpful response, but that part you got wrong.

Do not point people to patchwork checks, please. It will only encourage
people to post stuff they haven't build tested themselves.

It's documented:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#running-all-the-builds-and-checks-locally-is-a-pain-can-i-post-my-patches-and-have-the-patchwork-bot-validate-them

Only people who helped write the code and maintain the infra can decide
how to use it which means me, Kees, or Hangbin. Please and thank you :S
