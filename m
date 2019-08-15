Return-Path: <pruddy@vyatta.att-mail.com>
Message-ID: <45a527bf8946b52abb939fbdf844c98ac3ee7c0f.camel@vyatta.att-mail.com>
From: Patrick Ruddy <pruddy@vyatta.att-mail.com>
Reply-To: pruddy@vyatta.att-mail.com
Date: Thu, 15 Aug 2019 14:36:39 +0100
In-Reply-To: <d0be5038-e76f-d21b-a034-e450cbb3010e@cumulusnetworks.com>
References: <20190813141804.20515-1-pruddy@vyatta.att-mail.com>
	<20190813195341.GA27005@splinter>
	<43ed59db-9228-9132-b9a5-31c8d1e8e9e9@cumulusnetworks.com>
	<620d3cfbe58e3ae87ef1d5e7f2aa1588cac3e64a.camel@vyatta.att-mail.com>
	<20190814201138.GE2431@otheros>
	<d0be5038-e76f-d21b-a034-e450cbb3010e@cumulusnetworks.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next] mcast: ensure L-L IPv6 packets are
 accepted by bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: Ido Schimmel <idosch@idosch.org>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, netdev@vger.kernel.org

On Wed, 2019-08-14 at 23:34 +0300, Nikolay Aleksandrov wrote:
> On 8/14/19 11:11 PM, Linus Lüssing wrote:
> > On Wed, Aug 14, 2019 at 05:40:58PM +0100, Patrick Ruddy wrote:
> > > The group is being joined by MLD at the L3 level but the packets are
> > > not being passed up to the l3 interface becasue there is a MLD querier
> > > on the network
> > > 
> > > snippet from /proc/net/igmp6
> > > ...
> > > 40   sw1             ff0200000000000000000001ff008700     1 00000004 0
> > > 40   sw1             ff020000000000000000000000000002     1 00000004 0
> > > 40   sw1             ff020000000000000000000000000001     1 0000000C 0
> > > 40   sw1             ff010000000000000000000000000001     1 00000008 0
> > > 41   lo1             ff020000000000000000000000000001     1 0000000C 0
> > > 41   lo1             ff010000000000000000000000000001     1 00000008 0
> > > 42   sw1.1           ff020000000000000000000000000006     1 00000004 0
> > > 42   sw1.1           ff020000000000000000000000000005     1 00000004 0
> > > 42   sw1.1           ff0200000000000000000001ff000000     2 00000004 0
> > > 42   sw1.1           ff0200000000000000000001ff008700     1 00000004 0
> > > 42   sw1.1           ff0200000000000000000001ff000099     1 00000004 0
> > > 42   sw1.1           ff020000000000000000000000000002     1 00000004 0
> > > 42   sw1.1           ff020000000000000000000000000001     1 0000000C 0
> > > 42   sw1.1           ff010000000000000000000000000001     1 00000008 0
> > > ...
> > > 
> > > the bridge is sw1 and the l3 intervace is sw1.1
> > 
> > What kind of interface is sw1.1 exactly? Is it a VLAN or a VRF
> > interface? Something else?
> > 
> +1
> 
> > Could you also post the output of bridge mdb show?
> > 
> > Regards, Linus
> > 
> > 
> > PS: Also please include the bridge mailinglist in the future.
> > 
> 
> Note that if you'd like to debug a host joined group currently bridge mdb show
> will not dump it and if the group is host-joined only it
> can even be empty. You can use my latest set (not applied yet):
> https://urldefense.proofpoint.com/v2/url?u=http-3A__patchwork.ozlabs.org_project_netdev_list_-3Fseries-3D125169&d=DwIDaQ&c=LFYZ-o9_HUMeMTSQicvjIg&r=au3D9TlUU6OvFpWOU9cuIHeNeV2fw-AOF1ZqCRqsILc&m=KsdarH0MAMMoKZ4PuvHrEC57uEluTGK-XSL4uUxu9MY&s=jyoK6VVmFh1KpKZirrtUYwq9nLy8fz-GigFFLjaLsoE&e=
> 
> Alternatively you could monitor the mdb events, it will show up there even
> today without any changes (bridge monitor mdb) and you can check if it's
> getting deleted.
> 
> Cheers,
>  Nik

The sw1.1 interface is a .1q vlan

The output of "bridge monitor mdb" is empty

I can see the incoming query and the outging report on tshark:
29002 72654.887739 fe80::4041:1ff:fe00:101 → ff02::1      ICMPv6 94
Multicast Listener Query
29003 72655.502035 fe80::eac5:7aff:fe00:8700 → ff02::16     ICMPv6 194
Multicast Listener Report Message v2

debugging shows that bridge code sees the incoming query but not the
outgoing report.

Thanks for all the pointers - I will pursue what is happening.

-pr 

