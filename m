Return-Path: <bounce+52adeb.be9e4a-bridge=lists.linux-foundation.org@mg.codeaurora.org>
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1604921207; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=LXllegkU9Hqrn8ABy4ZLKOXWg3z4jJFDK0NqabfEc9c=;
 b=GAeZEjkcQ/myVWtCFhJ5Zg6dYn7slYdV1gxRDT5tDw0vCnTORfyYS7qHUucGJIibXRCr8rrq
 P/pLLk+RsAXhGS4UH1+RowQ0MSQSYA1ljlYsI03gCzj+T//DSW3aAfziAvKOp0cPoYcFTqNE
 j8BaGyy6x9Kgs72EbVNI+BWNLO0=
Sender: kvalo=codeaurora.org@mg.codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
References: <20201106221743.3271965-1-arnd@kernel.org>
 <20201107160612.2909063a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <87tuu05c23.fsf@tynnyri.adurom.net>
 <CAK8P3a3y5WxsibmTzvhv76G+rQ1Zjo_tW0UkXku0VnZdQa-__A@mail.gmail.com>
Date: Mon, 09 Nov 2020 13:25:48 +0200
In-Reply-To: <CAK8P3a3y5WxsibmTzvhv76G+rQ1Zjo_tW0UkXku0VnZdQa-__A@mail.gmail.com>
 (Arnd Bergmann's message of "Sun, 8 Nov 2020 12:42:49 +0100")
Message-ID: <87imaeg4ar.fsf@codeaurora.org>
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
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, Networking <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, linux-wireless <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-hams@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Christoph Hellwig <hch@lst.de>, Heiner Kallweit <hkallweit1@gmail.com>

Arnd Bergmann <arnd@kernel.org> writes:

> On Sun, Nov 8, 2020 at 12:21 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>> Jakub Kicinski <kuba@kernel.org> writes:
>>
>> So I don't know what to do. Should we try adding a warning like below? :)
>>
>>   "This ancient driver will be removed from the kernel in 2022, but if
>>    it still works send report to <...@...> to avoid the removal."
>>
>> How do other subsystems handle ancient drivers?
>
> A good way to get everyone's attention would be to collect as many
> drivers as possible that are almost certainly unused and move them to
> drivers/staging/ with a warning like the above, as I just did for
> drivers/wimax. That would make it to the usual news outlets
> and lead to the remaining users (if any) noticing it so they can then
> ask for the drivers to be moved back -- or decide it's time to let go
> if the hardware can easily be replaced.

I like that. I think we first should make a list of drivers which we
suspect are either unused or not working anymore.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
