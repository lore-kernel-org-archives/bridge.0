Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E16F960BCD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2FFE160BCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664467839;
 bh=Y6I9baSJX7t5noQG7pic8bbMiKke70Jgc+M0Pyupuok=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Pqfy6CpH04vXHNlCeK8divuCivx2ROtaBL3uONDUej220w1nMOTrfkrIWkCha3cf0
 mYqgG4WF0OV/y+aDBeObSFdyBirolLFDw+VUqOkkb70Rg1KH2/kEPjOVDoe+UZah8t
 fUfA/CA+o2xOimsnrbCe7bhgbkI5z38o8HC9pZ+5F+SUKe21VNP2UU3w0PlZHujG2b
 jlZ11ePpC6UfyRLTHltwyYZwK1XHXpI7O11NQ8du4cieCcQFDnHlv+gSQy8zMlSlYz
 tXHZMSs03B6i2mo5I3+1x48nn29HmyvGkPlSCx6W8htFtsLAALZ48d9Hp7jndUrUws
 FwKbObCc3ej9w==
Date: Thu, 29 Sep 2022 09:10:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220929091036.3812327f@kernel.org>
In-Reply-To: <20220928150256.115248-1-netdev@kapio-technology.com>
References: <20220928150256.115248-1-netdev@kapio-technology.com>
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
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Florent Fourcot <florent.fourcot@wifirst.fr>, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Wed, 28 Sep 2022 17:02:47 +0200 Hans Schultz wrote:
> From: "Hans J. Schultz" <netdev@kapio-technology.com>
> 
> This patch set extends the locked port feature for devices
> that are behind a locked port, but do not have the ability to
> authorize themselves as a supplicant using IEEE 802.1X.
> Such devices can be printers, meters or anything related to
> fixed installations. Instead of 802.1X authorization, devices
> can get access based on their MAC addresses being whitelisted.

Try a allmodconfig build on latest net-next, seems broken.
