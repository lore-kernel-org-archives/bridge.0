Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mwNs9sbMiT48/yC3GT4P2Ahj6pFfoxZdiE2CUrDVtA=;
 b=G9LiHN9YNIb7MAzGh1DyFX8MDFHhCyZs1BIOpnbIley/mBaNbReGa6yVS/d5uuCnzmioRVOeNRDly8BBC/SbCYdc5GUEcjtzq70xmvjZho6BGQ8W6O1LMtwmiiy1KnOA1kG6/tnDh8mMKne2oaxPsTr6CMzOnxotgzzH5NcdWvU5XIWziQ55gOMf57/wYzhykefoKOyATFNjh4wPpDT/MP3D8XDjp3QIc40ePvi9gOmUvZPS8LUHOAsV497LFwsGJ5Fl+jJ0pARDca8YVPYnQYItcvQFlazyIieEWYPgpjXkXeSthXEL8P2PlLazao3Cp4W2bYJMFJjEl2ZSWobacg==
References: <20210512231941.19211-1-linus.luessing@c0d3.blue>
 <c5634f19-f9f3-5966-a5b3-a0a64ca4534b@nvidia.com>
 <20210513133423.GB2222@otheros>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
Message-ID: <81f96696-67df-798e-ebc6-ba11f5dea3da@nvidia.com>
Date: Thu, 13 May 2021 16:36:15 +0300
In-Reply-To: <20210513133423.GB2222@otheros>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v3 00/11] net: bridge: split IPv4/v6
 mc router state and export for batman-adv
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>

On 13/05/2021 16:34, Linus Lüssing wrote:
> On Thu, May 13, 2021 at 03:02:13PM +0300, Nikolay Aleksandrov wrote:
>> Nice work overall, thank you. I hope it was tested well. :)
>> It'd be great if later you could add some selftests.
>>
>> Cheers,
>>  Nik
> 
> Hi Nikolay,
> 
> I think I found a way now to better deal with the protocol
> specific hlist_for_each_entry(), by using hlist_for_each()
> and a helper function, to reduce the duplicate code
> with br_{ip4,ip6}_multicast_get_rport_slot() as you suggested
> (and also removing duplicate code with 
> br_{ip4,ip6}_multicast_mark_router()) and reworked patches 7
> and 9 a bit for that...
> 
> Sorry for the inconvience and my bad timing with your reviews. But
> thanks a lot for all your valuable feedback!
> 
> Also netdevbpf patchwork had a few more remarks, they should
> hopefully be fixed now, too.
> 
> Regards, Linus
> 

Awesome, I'll try to review the new set tonight or tomorrow at the latest.

Thanks,
 Nik

