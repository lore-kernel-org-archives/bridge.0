Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0893A41BB7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2919F41B2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cmxhzVAL1YB+RE9j89rBigO8T8NiP9SDGEamja0kPTU=;
 b=mtCezQ/4ENLZOEF1WPhS7b4U4jsIGRd8/PAJOEm4TbfJXF5yRk8XLRAdPGb1rZLIEM
 p/oxZEQmdwWqqUzKL/pPjO8GgLAAJ5r5hhmM34UPgM2OefKojgPmrTT91upH6Idws/FY
 ggCCKG5kyBEaOPcLbYuFVfsMgl9HGFLc9LowwDzC/70CU5++MaQRW0jxIwp/MtZ4Njb8
 g7nXKV6aP1OMxofbQWswWF1s7ZavDCGMKolxCBlolWPqeoVZ0K9oZ3YFJ8cdDNSNXlQs
 Rv487MwL3WQScTQ1iSPS1IcoxpYanEBF8b2q4R5j1hQiKwsY70oHAanDE4HAvgVLUdTa
 gBVg==
Date: Thu, 20 Oct 2022 16:12:22 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221020131222.fzgq7ashy6cdatyt@skbuf>
References: <20221018165619.134535-1-netdev@kapio-technology.com>
 <20221018165619.134535-9-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018165619.134535-9-netdev@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v8 net-next 08/12] drivers: net: dsa: add fdb
 entry flags incoming to switchcore drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Hans J. Schultz" <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Christian Marangi <ansuelsmth@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Yuwei Wang <wangyuweihx@gmail.com>, Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Florent Fourcot <florent.fourcot@wifirst.fr>, UNGLinuxDriver@microchip.com, davem@davemloft.net

On Tue, Oct 18, 2022 at 06:56:15PM +0200, Hans J. Schultz wrote:
> Ignore fdb entries with set flags coming in on all switchcore drivers.
> 
> Signed-off-by: Hans J. Schultz <netdev@kapio-technology.com>
> ---

Some very thorough documentation in Documentation/networking/dsa/dsa.rst
is necessary. I'm interested in seeing what those flags are, and what
are drivers supposed to do when they see them, other than ignoring them.
