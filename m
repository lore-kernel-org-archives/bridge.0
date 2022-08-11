Return-Path: <benjamin.poirier@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0400F40579
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED8E0400E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc; bh=DZrxMuUWLyOOGOzou+/YbJCnEI+s6JajXm/D/EndXY0=;
 b=A213iWRXguE8DZnpQIMCrIlREr6BNeY4UQGwFU3+PYimUNEcvxJJw745lEfZYjDOwC
 pJhyRN+HKo7MdLzRQ0VGBFR0DvPdMDYGxRvVe5d3srZwI7YG9GTpe2J2fgUgIJtqPZbU
 3Yy1Wng6CTobUIFcGP6KXOR0njOIjtvQJH2y6voZFeXExvMyEHCwSpzUY4wqFTPv1kBx
 RWpGI5dv6Ig07hVwydmV61S6Dmbf3EEVmlWl5sL04ETo7yiQdiTLeeReJoD/dtKFC73n
 zKAY2J4vX8Teg2OUP4Ty01m0cSBCh5Su788OlbfCe5tCgtpTqaYkkvkfNEDWIwexvhI/
 +x9A==
Date: Thu, 11 Aug 2022 14:09:21 +0900
From: Benjamin Poirier <benjamin.poirier@gmail.com>
Message-ID: <YvSPAatX80jGiS3x@d3>
References: <20220707152930.1789437-1-netdev@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220707152930.1789437-1-netdev@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v4 net-next 0/6] Extend locked port feature
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
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On 2022-07-07 17:29 +0200, Hans Schultz wrote:
> This patch set extends the locked port feature for devices
> that are behind a locked port, but do not have the ability to
> authorize themselves as a supplicant using IEEE 802.1X.
> Such devices can be printers, meters or anything related to
> fixed installations. Instead of 802.1X authorization, devices
> can get access based on their MAC addresses being whitelisted.
                                                    ^

Please consider using the alternate vocabulary discussed in
Documentation/process/coding-style.rst =A74.
