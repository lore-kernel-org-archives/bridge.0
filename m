Return-Path: <bounce+52adeb.be9e4a-bridge=lists.linux-foundation.org@mg.codeaurora.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1604834553; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=+a2nw8TOnWhGkjW2VdGmo04dSuvzksPHyNngfg5RaIM=;
 b=PuwUKSjZjKHLYrRIHOfFrHUNjiJrB1JagzLx1xUwUhrg/tRiTCZqALjuD6mpWA2C4VpoEIM7
 7cMZZM5ngqrDE/gjmzQhMBd1fQk4KN09U+4kjUPydKYqiHuwzATLavIRP/P6aSEEFhZ+ZR9c
 yjt3z7gvRWDKRS6escEYh3uzixk=
Sender: kvalo=codeaurora.org@mg.codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
References: <20201106221743.3271965-1-arnd@kernel.org>
 <20201107160612.2909063a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Date: Sun, 08 Nov 2020 13:21:24 +0200
In-Reply-To: <20201107160612.2909063a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 (Jakub Kicinski's message of "Sat, 7 Nov 2020 16:06:12 -0800")
Message-ID: <87tuu05c23.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [RFC net-next 00/28] ndo_ioctl rework
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, linux-hams@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Christoph Hellwig <hch@lst.de>, Heiner Kallweit <hkallweit1@gmail.com>

Jakub Kicinski <kuba@kernel.org> writes:

>> For the wireless drivers, removing the old drivers
>> instead of just the dead code might be an alternative, depending
>> on whether anyone thinks there might still be users.
>
> Dunno if you want to dig into removal with a series like this, 
> anything using ioctls will be pretty old (with the exception 
> of what you separated into ndo_eth_ioctl). You may get bogged 
> down.

I would very much like to get rid of unused ancient wireless drivers but
the problem is that it's next to impossible to know if someone still
uses a driver, or if the driver is even working. For example, few months
back I suggested removing one driver which I thought to be completely
unused (forgot already the name of the driver) and to my big surprise
there was still a user, and he reported it working with a recent kernel
release.

So I don't know what to do. Should we try adding a warning like below? :)

  "This ancient driver will be removed from the kernel in 2022, but if
   it still works send report to <...@...> to avoid the removal."

How do other subsystems handle ancient drivers?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
