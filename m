Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9068560C26
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B16560AFD
MIME-Version: 1.0
Date: Mon, 31 Oct 2022 17:40:36 +0100
From: netdev@kapio-technology.com
In-Reply-To: <Y1/fLCe3xApcBXCE@shredder>
References: <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-2-idosch@nvidia.com>
 <0b1655f30a383f9b12c0d0c9c11efa56@kapio-technology.com>
 <Y1/fLCe3xApcBXCE@shredder>
Message-ID: <4b70a4630474c0ce543e0fed70a36eaa@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 01/16] bridge: Add MAC
 Authentication Bypass (MAB) support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: petrm@nvidia.com, ivecera@redhat.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, vladimir.oltean@nxp.com, edumazet@google.com, mlxsw@nvidia.com, jiri@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 2022-10-31 15:43, Ido Schimmel wrote:
> On Sun, Oct 30, 2022 at 11:09:31PM +0100, netdev@kapio-technology.com 
> wrote:
>> On 2022-10-25 12:00, Ido Schimmel wrote:
>> > @@ -943,6 +946,14 @@ static int br_setport(struct net_bridge_port *p,
>> > struct nlattr *tb[],
>> >  	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_SUPPRESS,
>> > BR_NEIGH_SUPPRESS);
>> >  	br_set_port_flag(p, tb, IFLA_BRPORT_ISOLATED, BR_ISOLATED);
>> >  	br_set_port_flag(p, tb, IFLA_BRPORT_LOCKED, BR_PORT_LOCKED);
>> > +	br_set_port_flag(p, tb, IFLA_BRPORT_MAB, BR_PORT_MAB);
>> > +
>> > +	if ((p->flags & BR_PORT_MAB) &&
>> > +	    (!(p->flags & BR_PORT_LOCKED) || !(p->flags & BR_LEARNING))) {
>> > +		NL_SET_ERR_MSG(extack, "MAB can only be enabled on a locked port
>> > with learning enabled");
>> 
>> It's a bit odd to get this message when turning off learning on a port 
>> with
>> MAB on, e.g....
>> 
>> # bridge link set dev a2 learning off
>> Error: MAB can only be enabled on a locked port with learning enabled.
> 
> It's better if you suggest something else. How about:
> 
> "Bridge port must be locked and have learning enabled when MAB is 
> enabled"
> 
> ?

Yes, I think that is better in case it should not be split into more 
than one
message. At least it is not bound to a specific action.
