Return-Path: <mmanning@vyatta.att-mail.com>
Reply-To: mmanning@vyatta.att-mail.com
References: <20190422093307.10206-1-idosch@mellanox.com>
	<335b31d0-9a65-0a2d-2b6c-339e42eddad1@cumulusnetworks.com>
From: Mike Manning <mmanning@vyatta.att-mail.com>
Message-ID: <aecd4008-5795-0392-3e81-4bf5726cbbc0@vyatta.att-mail.com>
Date: Mon, 22 Apr 2019 18:24:23 +0100
MIME-Version: 1.0
In-Reply-To: <335b31d0-9a65-0a2d-2b6c-339e42eddad1@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Bridge] [PATCH net-next] bridge: Fix possible use-after-free
 when deleting bridge port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Ido Schimmel <idosch@mellanox.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, mlxsw <mlxsw@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

On 22/04/2019 10:44, Nikolay Aleksandrov wrote:
> On 22/04/2019 12:33, Ido Schimmel wrote:
>> When a bridge port is being deleted, do not dereference it later in
>> br_vlan_port_event() as it can result in a use-after-free [1] if the RCU
>> callback was executed before invoking the function.
>>
> [snip]
>> Fixes: 9c0ec2e7182a ("bridge: support binding vlan dev link state to vlan member bridge ports")
>> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
>> Cc: Mike Manning <mmanning@vyatta.att-mail.com>
>> ---
>>  net/bridge/br.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bridge/br.c b/net/bridge/br.c
>> index e69fc87a13e0..3c8e4b38f054 100644
>> --- a/net/bridge/br.c
>> +++ b/net/bridge/br.c
>> @@ -129,7 +129,8 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
>>  		break;
>>  	}
>>  
>> -	br_vlan_port_event(p, event);
>> +	if (event != NETDEV_UNREGISTER)
>> +		br_vlan_port_event(p, event);
>>  
>>  	/* Events that may cause spanning tree to refresh */
>>  	if (!notified && (event == NETDEV_CHANGEADDR || event == NETDEV_UP ||
>>
> Right, the br_del_if is just above. :)
>
> Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Thanks for the fix, to avoid this I should have placed the check for the
br opt under the case handling in br_vlan_port_event().

Acked-by: Mike Manning <mmanning@vyatta.att-mail.com>

