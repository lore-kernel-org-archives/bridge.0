Return-Path: <linus.luessing@c0d3.blue>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3ABEC40F4E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A29440E46
Date: Tue, 8 Aug 2023 02:29:09 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <ZNGMVUNsZWWUd7so@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Bridge] Getting + maintaining a consistent MDB view in userspace?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,

Is there a recommended way to get and monitor the MDB state from
userspace, without potential synchronization races?

I can use "bridge monitor mdb" to get changes or "bridge mdb show"
to get the current state (as well as use the underlying netlink
calls from my own application without the "bridge" command).

But if I were first calling "bridge mdb show" and then "bridge
monitor mdb" then there is a brief moment where I might miss some
changes. Or if I were doing it the other way around then a change
might wrongly override a valid entry? Or the full dump might not
be as up to date as the change event I got before?

Ideally I'd be looking for a variant of "bridge monitor mdb" which
first dumps the whole, consistent mdb state and after that
provides updates in the correct order.

Regards, Linus
