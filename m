Return-Path: <petrm@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 035F141823
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04C1441795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XubIOGUXV39izAf99aI9nDczchTciAZ7WPlcFxA6S8U=;
 b=eSegMNTqTjF59Lx0ZGErrriFu+Oeg/Qd9JnmzYBvzCmKEfMmHppJYCgCEbzImGj4Dex7XGqpF3ibW3RNzXEyAw8y/ygdsB3vmU6vvqMGylWzk85sV9bC7k29n3vnPpuQ3z7P1BWPucM9wPrFCId2GqJGwJl+UeP1FZ7jfZLNXYVGbfVmcxVgNUJGxoyFERTIBZXVBaBcDjfUqm3/AAbHjyO8TADr3yoxQ1VsRqhz9Rt2DKMZ/s+OvBOVd6k2Hh9IjzT0cSnh0g92sSynLo7Xdoj5e7iTBqTjq274VZFYPMiAAFCF0WxOL+y5GmwhdQTGPEkGVKelEvv2yRMJ+MdE/g==
References: <cover.1674752051.git.petrm@nvidia.com>
 <ed2e2e305dd49423745b62c0152a0b85bc84a767.1674752051.git.petrm@nvidia.com>
 <20230126125344.1b7b34e2@gandalf.local.home>
From: Petr Machata <petrm@nvidia.com>
Date: Mon, 30 Jan 2023 16:50:32 +0100
In-Reply-To: <20230126125344.1b7b34e2@gandalf.local.home>
Message-ID: <87ilgof20x.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH net-next 06/16] net: bridge: Add a tracepoint
 for MDB overflows
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Thu, 26 Jan 2023 18:01:14 +0100
> Petr Machata <petrm@nvidia.com> wrote:
>
>> +	TP_printk("dev %s af %u src %pI4/%pI6c grp %pI4/%pI6c/%pM vid %u",
>> +		  __get_str(dev), __entry->af, __entry->src4, __entry->src6,
>> +		  __entry->grp4, __entry->grp6, __entry->grpmac, __entry->vid)
>
> And just have: 
>
> 	TP_printk("dev %s af %u src %pI6c grp %pI6c/%pM vid %u",
> 		  __get_str(dev), __entry->af, __entry->src, __entry->grp,
> 		  __entry->grpmac, __entry->vid)
>
> As the %pI6c should detect that it's a ipv4 address and show that.

This means the IP addresses will always be IPv6, even for an IPv4 MDB
entries. One can still figure out the true protocol from the address
family field, but it might not be obvious. Plus the IPv4-mapped IPv6
addresses are not really formatted as IPv4, though yeah, IPv4 notation
is embedded in that.

All the information is still there, but... scrambled? Not sure the
reduction in clarity is worth the 8 bytes that we save. The tracepoint
is unlikely to trigger often.

What say you?
