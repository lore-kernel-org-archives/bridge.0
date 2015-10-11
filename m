Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-type:content-transfer-encoding;
	bh=ZfYYmNNNdx6qokKAeUT6mCzs5kJlF2oQ9s4Zd+LLagg=;
	b=Y1T+8Wz+wjk//ERHQmvL37omnIcRR33Q9o3d4ymxuTV1wVYHgerK9lePedFDeit6af
	S6aDueyTV3JnH9ohqlwyIokhBYjUaS2cI0hZJ0zXfqx4Nwm6X9H0NsHGJao4mUOanrB5
	I2JuuAnwntrONOJj4bmXMWMBUpcfXXJUDM+bs=
References: <1443637015-4153-1-git-send-email-razor@blackwall.org>
	<1443637015-4153-5-git-send-email-razor@blackwall.org>
	<20151011122118.GB2793@colbert.mtl.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <561A5918.5050404@cumulusnetworks.com>
Date: Sun, 11 Oct 2015 14:42:00 +0200
MIME-Version: 1.0
In-Reply-To: <20151011122118.GB2793@colbert.mtl.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 4/5] bridge: vlan: fix possible null
 ptr derefs on port init and deinit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, vyasevich@gmail.com

On 10/11/2015 02:21 PM, Ido Schimmel wrote:
> Wed, Sep 30, 2015 at 09:16:54PM IDT, razor@blackwall.org wrote:
>> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>>
>> When a new port is being added we need to make vlgrp available after
>> rhashtable has been initialized and when removing a port we need to
>> flush the vlans and free the resources after we're sure noone can use
>> the port, i.e. after it's removed from the port list and synchronize_rcu
>> is executed.
> 
> Hi Nikolay,
> 
> Changing the order of port deinit breaks symmetry with the init
> sequence. It also introduces a problem for switchdev drivers. Flushing
> the VLANs clears HW VLAN filters and then, when port is unlinked from
> bridge and CHANGEUPPER is received, port is configured to direct traffic
> to CPU (as it's not offloaded anymore). Doing the reverse (like in this
> patch) renders the port unusable.
> 
> Regarding the reason for this change, are you afraid that vlgrp will be
> accessed in bridge's rx handler or xmit function after it's freed? If
> so, maybe we can access it using RCU primitives? That way, both the rx
> handler and xmit function (executed under RCU lock) will either have a
> valid copy or not. Looking at previous iterations of this code, I see
> that was the case with the 'net_port_vlans' struct.
> 
> I can start working on a fix if you agree with the proposed solution.
> 
> Thanks.
> 

Hi,
Ah, I didn't know about this, I feared that something might rely on the
particular order of the operations but didn't have a way to test this one in
particular. Anyway, your proposed solution sounds good to me.

Thank you,
 Nik


