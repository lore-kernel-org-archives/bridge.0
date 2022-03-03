Return-Path: <bigeasy@linutronix.de>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1646327712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QA9292ErVJBK3Dbl+AyvCtdfJtIr/aoQIN3k0viXtpQ=;
 b=v18fWMhrIMzCeoFgxsf70BbWn4cVKFGWxNEbyBR3CiiwMhqX6GIlHqTifHamPdb+cxOhOi
 JvBHjeRxT2vKKPdAnbVHCMOoqyx9WDCSRV5ycxYXXUi+Ghm8lqkU52ZUhN5hNsfDPlrWE9
 2PGGqXg4HQDsUmQw3hVsTRJA0Ur4QEdVcwwVismFCt9IyVqDLdJg2v5i04zR3KZfwycHbx
 zk7crLioyZ3Zlsx47Ua2FaKQ0fx8Ws4g51iwG49Zvb0W3mz4NbKGhbZmUZT2vQwrKChi09
 JWWSmq9a74oUhi1VAsndcMHSv3MLAs8SNtlfg3xLqVCrA6lNydt9ck0oERAQoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1646327712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QA9292ErVJBK3Dbl+AyvCtdfJtIr/aoQIN3k0viXtpQ=;
 b=w/urUxUmHyvO2vZ0BDlhWhqntVfH+hl4j06fJsdYIzfNwdzkUVT+dDpfKb/fM0FjxGEqTi
 fs7bEubj+R6bWUCg==
Date: Thu,  3 Mar 2022 18:14:56 +0100
Message-Id: <20220303171505.1604775-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] [PATCH net-next 0/9] net: Convert user to netif_rx().
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Kurt Kanzenbach <kurt@linutronix.de>, Max Filippov <jcmvbkbc@gmail.com>, Steve Wahl <steve.wahl@hpe.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Florian Fainelli <f.fainelli@gmail.com>, Jonathan Corbet <corbet@lwn.net>, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, linux-xtensa@linux-xtensa.org, Mike Travis <mike.travis@hpe.com>, =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>, Thomas Gleixner <tglx@linutronix.de>, Chris Zankel <chris@zankel.net>, Robin Holt <robinmholt@gmail.com>, UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>

This is the first batch of converting netif_rx_ni() caller to
netif_rx(). The change making this possible is net-next and
netif_rx_ni() is a wrapper around netif_rx(). This is a clean up in
order to remove netif_rx_ni().

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: bridge@lists.linux-foundation.org
Cc: Chris Zankel <chris@zankel.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kurt Kanzenbach <kurt@linutronix.de>
Cc: linux-doc@vger.kernel.org
Cc: linux-xtensa@linux-xtensa.org
Cc: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Robin Holt <robinmholt@gmail.com>
Cc: Roopa Prabhu <roopa@nvidia.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: UNGLinuxDriver@microchip.com
Cc: Vivien Didelot <vivien.didelot@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>
Sebastian


