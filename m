Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0671642408
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D7381419BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qPwKKOSL5o3iKP3/dq2Q/Xqf5eS+OyCN/8/d6oWiIbo=;
 b=Wez6UWR4yVy7ljjWDwKmXH6VNrw+c4JqEj+dW/C4iE13oGKDcKlajUuNqxj6oLepyi
 C0skbvziSspULzvlwn8TBGB6Tv1ygZ83Nk9yz7CmVwEt93bAqdM1W+mP5lRva/Mu2sfA
 wUJ27HWB96G1EoRapxy1zVd0dSfec6ORQh0UyIB4LVjAyzUCUXaiRRDCLvVFoEQ8Rdxg
 Ub7Q/WvBLNLViJ6sWzK+Oz8/bF7ofcwRMyWfFsvy2ESmkC+fRO+XYiQFfPUaUZI46ja+
 kaaUkAOdxxOythUrOTUZPvVTZDJCnY2dlbASFAtPDOc6Xi/cXW/qf28qa4TWVPqSRx7W
 vAKg==
Date: Thu, 20 Oct 2022 18:36:36 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221020153636.ceqk67hmut3govsp@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221018165619.134535-6-netdev@kapio-technology.com>
 <20221020130224.6ralzvteoxfdwseb@skbuf> <Y1FMAI9BzDRUPi5Y@shredder>
 <20221020133506.76wroc7owpwjzrkg@skbuf> <Y1FTzyPdTbAF+ODT@shredder>
 <20221020141104.7h7kpau6cnpfqvh4@skbuf> <Y1Fn+TnbI/uMH0VR@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Fn+TnbI/uMH0VR@shredder>
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
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, "Hans J. Schultz" <netdev@kapio-technology.com>, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Thu, Oct 20, 2022 at 06:23:37PM +0300, Ido Schimmel wrote:
> 3. Miss. FDB entry not found. Here I was thinking to always tell the
> packet to go to the software data path so that it will trigger the
> creation of the "locked" entry if MAB is enabled. If MAB is not enabled,
> it will simply be dropped by the bridge. We can't control it per port in
> hardware, which is why the BR_PORT_MAB flag is not consulted.

Ah, ok, this is the part I was missing, so you can't control an FDB miss
to generate a learn frame only on some ports. But in principle, it still
is the BR_PORT_MAB flag the one which requires these frames to be generated,
not BR_PORT_LOCKED. You can have all ports LOCKED but not MAB, and no
learn frames will be necessary to be sent to the CPU. Only EAPOL, which
is link-local multicast, will reach software for further processing and
unlock the port for a certain MAC DA.
