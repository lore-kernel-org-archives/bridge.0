Return-Path: <stephen@networkplumber.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 56294401E8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 548BC401E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
 bh=b7VI/lNtki3zEef+0LBeBHdkR7jGYNMrvxJja3PqG/c=;
 b=Vzksrx3sniIo56OPl72BWHlU0/Df8j/JQCbDZvy1EGrf7kGm7B2aiZfENf5gW44D/J
 gI9Z0IM1eNvyuoepwUgJtEreELCtd/Yi97PNwccOEhM6E0notm+GqKPkHLkR9oYsyKb8
 Yoq/pleXGN8k4RyGciZfN2tWjdiAPNPkdJ0GRF8seENVYF2FOicZ45TlpxCNGouCgsOp
 P0XmWHkJpwHysnW3nZxveeGX+rb2ESXrOcsYARReYp7X/HAFCqXhQu1KdtVjt8W5CRIo
 QDL3OSbkonYl6GqgtkUeoFLMwgh1qC0e+3cPxCbPucD2iWViRSqwTxmu6i6Uq7X8iEVv
 wfYA==
Date: Thu, 29 Sep 2022 08:43:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20220929084312.2a216698@hermes.local>
In-Reply-To: <20220929152137.167626-2-netdev@kapio-technology.com>
References: <20220929152137.167626-1-netdev@kapio-technology.com>
 <20220929152137.167626-2-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH iproute2-next 2/2] bridge: fdb: enable FDB
 blackhole feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <netdev@kapio-technology.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, Joachim Wiberg <troglobit@gmail.com>, UNGLinuxDriver@microchip.com, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Florent Fourcot <florent.fourcot@wifirst.fr>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Yuwei Wang <wangyuweihx@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Hans Schultz <schultz.hans@gmail.com>, Sean Wang <sean.wang@mediatek.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, Petr Machata <petrm@nvidia.com>, Hauke Mehrtens <hauke@hauke-m.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net

On Thu, 29 Sep 2022 17:21:37 +0200
Hans Schultz <netdev@kapio-technology.com> wrote:

>  
> @@ -493,6 +496,8 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
>  			req.ndm.ndm_flags |= NTF_EXT_LEARNED;
>  		} else if (matches(*argv, "sticky") == 0) {
>  			req.ndm.ndm_flags |= NTF_STICKY;
> +		} else if (matches(*argv, "blackhole") == 0) {
> +			ext_flags |= NTF_EXT_BLACKHOLE;
>  		} else {
>  			if (strcmp(*argv, "to") == 0)
>  				NEXT_ARG();

The parsing of flags is weird here, most of the flags are compared with strcmp()
but some use matches()..  I should have used strcmp() all the time; but at the
time did not realize what kind of confusion matches() can cause.
