Return-Path: <vyasevic@redhat.com>
Message-ID: <510C7637.7080102@redhat.com>
Date: Fri, 01 Feb 2013 21:13:11 -0500
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <1359748930-31475-1-git-send-email-vyasevic@redhat.com>
	<1359748930-31475-3-git-send-email-vyasevic@redhat.com>
	<CAHXqBFLTaPbReQh-vgc_kbBbUtEWOFyE2oq85boWoHFD2+Tm9w@mail.gmail.com>
In-Reply-To: <CAHXqBFLTaPbReQh-vgc_kbBbUtEWOFyE2oq85boWoHFD2+Tm9w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH v9 net-next 02/12] bridge: Validate that vlan
 is permitted on ingress
Reply-To: vyasevic@redhat.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus@gmail.com>
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 02/01/2013 08:04 PM, Michał Mirosław wrote:
> 2013/2/1 Vlad Yasevich <vyasevic@redhat.com>:
>> When a frame arrives on a port or transmitted by the bridge,
>> if we have VLANs configured, validate that a given VLAN is allowed
>> to enter the bridge.
> [...]
>> +static inline struct net_port_vlans *br_get_vlan_info(
>> +                                               const struct net_bridge *br)
>> +{
>> +       return rcu_dereference(br->vlan_info);
>> +}
>> +
>> +static inline struct net_port_vlans *nbp_get_vlan_info(
>> +                                               const struct net_bridge_port *p)
>> +{
>> +       return rcu_dereference(p->vlan_info);
>> +}
>
> Those should go to patch #1.

They are not needed till here.  I thought it would read/review better if 
I kept it together.

-vlad
>
> Best Regards,
> Michał Mirosław
>

