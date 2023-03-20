Return-Path: <royujjal@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B709C4156A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 59A7F415DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679312713;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2EdCdWaxl6aSDm2/QNnErzsl1SoS7RrMeG7Y44iKUtc=;
 b=C8obbCNO7LejGk5rUhOzu1LitH8G2CvYqXpW3dW3Oedqzodtr0rk41gi7CdYDAge5j
 oVRhkfHNTWVF07feFWtcK4fjvG1Cw8xPjJ/yb+jwE9eQmxViwPZfCvWGAuSHWMEnGQyh
 w2nkV8EndlS0GjJNT/xy16JZhB9KQE9tqA8EwY5UajOpBYbi8M6u3UCtR9BTu8sQR030
 v48qDfGg0zjHpIl1yLuMfT44LUxd8c/BOvTMkR7myfFgdhFt1oll9MAwbyP8j1s9Wv2+
 +ta6yfTTS9m0S57Yxsl5jpMXMUs+tzI3oQdq/xwBLpeDdbYvBcVY6KwZnC1nE9NrOi6m
 3rew==
MIME-Version: 1.0
From: Ujjal Roy <royujjal@gmail.com>
Date: Mon, 20 Mar 2023 17:15:00 +0530
Message-ID: <CAE2MWkm=zvkF_Ge1MH7vn+dmMboNt+pOEEVSgSeNNPRY5VmroA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Bridge] Multicast: handling of STA disconnect
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: roopa@nvidia.com, razor@blackwall.org, nikolay@nvidia.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Kernel <linux-kernel@vger.kernel.org>

Hi Nikolay,

I have some query on multicast. When streams running on an STA and STA
disconnected due to some reason. So, until the MDB is timed out the
stream will be forwarded to the port and in turn to the driver and
dropps there as no such STA.

So, is the multicast_eht handling this scenario to take any action
immediately? If not, can we do this to take quick action to reduce
overhead of memory and driver?

I have an idea on this. Can we mark this port group (MDB entry) as
INACTIVE from the WiFi disconnect event and skip forwarding the stream
to this port in br_multicast_flood by applying the check? I can share
the patch on this.

Thanks,
UjjaL Roy
