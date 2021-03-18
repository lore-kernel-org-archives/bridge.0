Return-Path: <g.danti@assyoma.it>
MIME-Version: 1.0
Date: Thu, 18 Mar 2021 08:53:58 +0100
From: Gionatan Danti <g.danti@assyoma.it>
Message-ID: <ca6f3aa9149a74e9990a335b6046f133@assyoma.it>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Extract untagged traffic from bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi list,
I have a question regarding the use of bridges with vlans.

Suppose I have a lanbr which bridges together eth0 and various virtual 
interfaces. Putting aside bridge vlan filtering, any interface connected 
to the bridge will see both untagged and tagged traffic.

To only see the tagged traffic portion of specific vlan I can simple 
create a bridge vlan interface (eg: lanbr.10) and use that virtual 
interface as a member of another bridge. In other words:
eth0 -> lanbr -> lanbr.10 -> vlan10br

Now, I wonder if it is possible to extract *only* the untagged traffic 
from the lanbr bridge. Something similar to that:
eth0 -> lanbr -> lanbr.untagged -> untbr

Full disclosure: a virtual machine bridged on lanbr will see both tagged 
and untagged traffic. This is fine for, say, a virtual firewall with a 
trunk interface. However, I do not want any other VM residing on the 
untagged bridge to see tagged traffic. So I need to confine these 
machines to see only untagged packet.

One possible approach would be to use ebtables to drop 802.1q tagged 
packets on lanbr unless they are for a specific virtual machine 
interface (and it seems to work well), but I wonder if the same can be 
obtained without calling ebtables into the mix.

Regards.

-- 
Danti Gionatan
Supporto Tecnico
Assyoma S.r.l. - www.assyoma.it
email: g.danti@assyoma.it - info@assyoma.it
GPG public key ID: FF5F32A8
