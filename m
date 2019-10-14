Return-Path: <richard.weinberger@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to:cc;
	bh=RL+qRYT6Goj58mWMl95r8FGMxjYOCcO4sf1iNuaKh9U=;
	b=dMpX4osW+Gizh9wuXThIULR+SMojXNXSVsVvoWi5OvVzxXiLGj195gyZ0EdA3ugmnf
	pNJa9ZRwkxgN96umOkiqmG22sEeEnHfHxbwOCABF932ETOIQozeKKpwV4kOYVqDZdYpg
	HCazf1SLvF8mNO3JApRICKFlRopM9A0+MQ9KKpJvlyBDThEZ2i3z8fb3COic55OAQtJM
	8uPRQDu4QUAbItWuMpA1YNQofcuzZx5hpVW/0/UlNHEzP8FGK2ePDh9KDJ/pasgRXdbd
	qmhX6qiIJmhColRpPsyAtExuKOWc9pX84aDJFFd9WvWi3x/EZikS4XryeAB1saHR+0vu
	jghQ==
MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 14 Oct 2019 22:33:22 +0200
Message-ID: <CAFLxGvwnOi6dSq5yLM78XskweQOY6aPbRt==G9wv5qS+dfj8bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Bridge] Bridge port userspace events broken?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: nikolay@cumulusnetworks.com, Greg KH <gregkh@linuxfoundation.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org

Hi!

My userspace needs /sys/class/net/eth0/brport/group_fwd_mask, so I set
up udev rules
to wait for the sysfs file.
Without luck.
Also "udevadm monitor" does not show any event related to
/sys/class/net/eth0/brport when I assign eth0 to a bridge.

First I thought that the bridge code just misses to emit some events but
br_add_if() calls kobject_uevent() which is good.

Greg gave me the hint that the bridge code might not use the kobject model
correctly.

Enabling kobjekt debugging shows that all events are dropped:
[   36.904602] device eth0 entered promiscuous mode
[   36.904786] kobject: 'brport' (0000000028a47e33): kobject_uevent_env
[   36.904789] kobject: 'brport' (0000000028a47e33):
kobject_uevent_env: filter function caused the event to drop!

If I understood Greg correctly this is because the bridge code uses
plain kobjects which
have a parent object. Therefore all events are dropped.

Shouldn't brport be a kset just like net_device->queues_kset?

-- 
Thanks,
//richard
