Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DECA5817ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCF738194C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPIEZNk08XXFrQmWW3ATki8MZAqw1XX37c8AH/JEm8I=;
 b=KZAyk0engENwoT3cERPwJnv53FekWcQnxWt2ZyghkSWohJvVso3wRWzlCRtE1t+oyiA44bLcZbaexRdCGHkjd31G5IplaY9nj0KmjYJGvLEWDOhJ2RJUZ1L/cj40WUkqdp7V7iGlz9aQAZm9lyXsYToRoghyVadYGRuuk3vpF/GJkY4ZJenmMlgzitFT8GGrhISocTNRedEMFuhdDWO38DKtwJGB4XgcJfuJHRx+feBbF864IVUDV9bIhLBcuMPEJSrOL5lu9ujYLeWPk7A3w+cUvwQu3CW2JAIXg/4x3kwL2sT9wDhBgfQSZ88RdGcu7TwcsXfbSY6KCAo/T3Xsqg==
References: <YxNo/0+/Sbg9svid@shredder>
 <5cee059b65f6f7671e099150f9da79c1@kapio-technology.com>
 <Yxmgs7Du62V1zyjK@shredder>
 <8dfc9b525f084fa5ad55019f4418a35e@kapio-technology.com>
 <20220908112044.czjh3xkzb4r27ohq@skbuf>
 <152c0ceadefbd742331c340bec2f50c0@kapio-technology.com>
 <20220911001346.qno33l47i6nvgiwy@skbuf>
 <15ee472a68beca4a151118179da5e663@kapio-technology.com>
 <Yx73FOpN5uhPQhFl@shredder>
 <086704ce7f323cc1b3cca78670b42095@kapio-technology.com>
 <Yyq6BnUfctLeerqE@shredder>
 <d559df70d75b3f5db2815f3038be3e3a@kapio-technology.com>
From: Petr Machata <petrm@nvidia.com>
Date: Tue, 27 Sep 2022 17:19:49 +0200
In-Reply-To: <d559df70d75b3f5db2815f3038be3e3a@kapio-technology.com>
Message-ID: <87k05ox2r2.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v5 net-next 6/6] selftests: forwarding: add
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
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, UNGLinuxDriver@microchip.com, Shuah Khan <shuah@kernel.org>, Ivan Vecera <ivecera@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, Yuwei Wang <wangyuweihx@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Christian Marangi <ansuelsmth@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Landen Chao <Landen.Chao@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Jiri Pirko <jiri@resnulli.us>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, davem@davemloft.net


netdev@kapio-technology.com writes:

> Thx, looks good.
> I have tried to run the test as far as I can manually, but I don't seem to have 'busywait' in the
> system, which tc_check_packets() depends on, and I couldn't find any 'busywait' in Buildroot.

It's a helper defined in tools/testing/selftests/net/forwarding/lib.sh
