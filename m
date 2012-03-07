Return-Path: <paulius.zaleckas@gmail.com>
Message-ID: <4F571674.6000107@gmail.com>
Date: Wed, 07 Mar 2012 10:04:04 +0200
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
MIME-Version: 1.0
References: <20120306142219.31783.30201.stgit@localhost.localdomain>
	<20120306.143323.1591818099708591757.davem@davemloft.net>
In-Reply-To: <20120306.143323.1591818099708591757.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: fix "entering disabled state" logging
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 03/06/2012 09:33 PM, David Miller wrote:
> From: Paulius Zaleckas<paulius.zaleckas@gmail.com>
> Date: Tue, 06 Mar 2012 16:22:19 +0200
>
>> Now we have:
>> eth0: link *down*
>> br0: port 1(eth0) entering *forwarding* state
>>
>> State should be logged *after* it was changed, not before.
>>
>> Reported-by: Zilvinas Valinskas<zilvinas@wilibox.com>
>> Signed-off-by: Paulius Zaleckas<paulius.zaleckas@gmail.com>
>
> This is intentional, this was a discussion about this.
>
> "Entering" means "about to" therefore we say it before it happens.

You have missed the whole point here... please look at dmesg output, I 
have bolded what you should pay attention to. It should say "entering 
disabled state" instead of "entering forwarding state".

However I do agree with you and Stephen that it should say "entered" and 
not "entering". I will send you patch changing this.

I will also resend this patch with better description.
