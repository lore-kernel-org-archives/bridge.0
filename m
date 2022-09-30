Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6943C60D5D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE1CA605E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lIYefaSOYiraQUJOth+slAJpWZICGu/4rJ81nJHNbs=;
 b=Hkpq6F8KKI22CIYyl4Ef7W3sd5RqzqEmhp4acJ0k1zFf5CRVr+GGORuDoAH4u2UIA34oQwWePCezrK63W1+UAdHAGlM93154mPkehovAn8XGIW9UMQn/4N/w6huovPln5xhHZHRdMgpNifo4SFqi3o9h9qOLWQjS+16OdHcGrdoJlbMeSKJyOLcRYf6ARc0xJL7rVq+/oA3nP9y/kKi4Y8Itv8KBgkBC7IAkyyqFBm+ETXdVPPO8JT5JbzQkiPYnY4/IsXcvA7aV/DA+dbstYgJDV0qJ8WTDTryINxOIUrTDZPJ+LlMIqw+5e0BoyEKl5kTk4P5D+UBzDhV0pcmhWg==
Date: Fri, 30 Sep 2022 17:05:20 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Yzb3oNGNtq4GCS3M@shredder>
References: <20220928150256.115248-1-netdev@kapio-technology.com>
 <20220929091036.3812327f@kernel.org>
 <12587604af1ed79be4d3a1607987483a@kapio-technology.com>
 <20220929112744.27cc969b@kernel.org>
 <ab488e3d1b9d456ae96cfd84b724d939@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab488e3d1b9d456ae96cfd84b724d939@kapio-technology.com>
MIME-Version: 1.0
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
To: netdev@kapio-technology.com
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Fri, Sep 30, 2022 at 07:42:37AM +0200, netdev@kapio-technology.com wrote:
> Obviously my method of selecting all switchcore drivers with sub-options
> under menuconfig was not sufficient, and I didn't know of the allmodconfig
> option, otherwise I would have used it.

You can see build issues on patchwork:

https://patchwork.kernel.org/project/netdevbpf/patch/20220928150256.115248-6-netdev@kapio-technology.com/

Also:

https://docs.kernel.org/next/process/maintainer-netdev.html#what-level-of-testing-is-expected-before-i-submit-my-change

https://docs.kernel.org/next/process/maintainer-netdev.html#can-i-reproduce-the-checks-from-patchwork-on-my-local-machine

https://docs.kernel.org/next/process/maintainer-netdev.html#running-all-the-builds-and-checks-locally-is-a-pain-can-i-post-my-patches-and-have-the-patchwork-bot-validate-them

> So the question is if I should repost the fixed patch-set or I need to make
> a new version?

A new fixed version (v7) is required, but wait for this version to be
reviewed first.

> Anyhow I hope that there will not be problems when running the selftests, as
> I have not been able to do so with my system, so there can be more that
> needs to be changed.

It's not really acceptable to post tests that you haven't run... What
exactly is the issue? You should be able to run the tests with veth
pairs in a VM.
