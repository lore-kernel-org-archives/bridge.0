Return-Path: <arnd@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604835786;
 bh=4qcv3PIZoS9Ti9M9OtYV1punEYgw5Sm+kDyvXqo+hQY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=cDRAdYzLiZ+IhL2nfUuSHGyRVDqNzeN5Fjmlbav0H0lAVvL8TtfEHblAcT4AQ9r7a
 5k/uNiUCUD/RLIEPkT/eoNdayDgyh4DLf9NojP8NIscEy0H6eZvXrIK/66ZPS5HRLl
 flfTLVRDxH0PYsg+WKGMIFIIZyanbx2eDzEYoTsg=
MIME-Version: 1.0
References: <20201106221743.3271965-1-arnd@kernel.org>
 <20201107160612.2909063a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87tuu05c23.fsf@tynnyri.adurom.net>
In-Reply-To: <87tuu05c23.fsf@tynnyri.adurom.net>
From: Arnd Bergmann <arnd@kernel.org>
Date: Sun, 8 Nov 2020 12:42:49 +0100
Message-ID: <CAK8P3a3y5WxsibmTzvhv76G+rQ1Zjo_tW0UkXku0VnZdQa-__A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [RFC net-next 00/28] ndo_ioctl rework
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kalle Valo <kvalo@codeaurora.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Networking <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, linux-wireless <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-hams@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Christoph Hellwig <hch@lst.de>, Heiner Kallweit <hkallweit1@gmail.com>

On Sun, Nov 8, 2020 at 12:21 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
>
> So I don't know what to do. Should we try adding a warning like below? :)
>
>   "This ancient driver will be removed from the kernel in 2022, but if
>    it still works send report to <...@...> to avoid the removal."
>
> How do other subsystems handle ancient drivers?

A good way to get everyone's attention would be to collect as many
drivers as possible that are almost certainly unused and move them to
drivers/staging/ with a warning like the above, as I just did for
drivers/wimax. That would make it to the usual news outlets
and lead to the remaining users (if any) noticing it so they can then
ask for the drivers to be moved back -- or decide it's time to let go
if the hardware can easily be replaced.

      Arnd
