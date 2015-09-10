Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 10 Sep 2015 16:42:54 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150910144254.GD8386@odroid>
References: <20150908031122.GB1562@odroid>
 <20150908085256.0f3f6b00@urahara>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150908085256.0f3f6b00@urahara>
Subject: Re: [Bridge] Roaming trouble with bridge & multicast snooping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org

On Tue, Sep 08, 2015 at 08:52:56AM -0700, Stephen Hemminger wrote:
> Why doesn't the client resend a IGMP when it notes
> a connection change?
> 

Good question, I actually had expected that too. My guess is that the
network stack might be interpreting the RFCs in a "conservative
way". RFC3376 ("Internet Group Management Protocol, Version 3" in
section 5 only describes the following two cases where a report should
be send:

-----
* a change of the interface reception state, caused by a local
  invocation of IPMulticastListen [!= interface link state].

* reception of a Query.
-----

Seems like another case where no one @IETF had thought about
layer 2 multicast snooping :(.


> The only entity in this scenario that knows that it has changed
> state is (c).

Hm, (B) should know so too as (c) authenticates to an 802.11
access point first before using it. So the mac80211 on (B) should
be aware of the new host immediately.


I'm wondering whether it'd be sufficient to change multicast
listener behaviour in Linux or whether the majority of wifi capable
devices would still experience multicast packetloss on roaming.
Anyone having an Apple or Microsoft device :)?

Cheers, Linus
