MIME-Version: 1.0
In-Reply-To: <OFB9321502.79301BE7-ONC12575D3.0075D3D1-C12575D3.00765847@transmode.se>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>
	<de7adc5e0906111251h563fe0b1ic28ae7004d8b3e7@mail.gmail.com>
	<m33aa5bykm.fsf@ursa.amorsen.dk>
	<OFEA0D61B2.8B351FDC-ONC12575D3.0034AA26-C12575D3.00354697@transmode.se>
	<20090612125214.GA7461@kallisti.us>
	<OF0314F87C.B7A0780D-ONC12575D3.00476B7B-C12575D3.00484E73@transmode.se>
	<2e59e6970906120619u589ed8dfy8bb327efa305b742@mail.gmail.com>
	<OF32E45445.B5790A30-ONC12575D3.004B77E2-C12575D3.004BBABD@transmode.se>
	<2e59e6970906121231x7278360u19bcc58646116469@mail.gmail.com>
	<OFB9321502.79301BE7-ONC12575D3.0075D3D1-C12575D3.00765847@transmode.se>
Date: Fri, 12 Jun 2009 23:29:31 -0500
Message-ID: <2e59e6970906122129q3cc1bdfakc30a8cc74478ab4a@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] RFC: Simple Private VLAN impl.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org, Benny Amorsen <benny+usenet@amorsen.dk>

>> If you want linux to act like a physical switch:
>>
>> add ethN.0 to br0
>> add ethN.1 to br1
>> add ethN.j to brj
>>
>> all VLANs will be isolated from each other just like a simple
>> VLAN-capable switch.
>>
>> If you don't want traffic from VLAN 4042 to go out over VLAN 4043,
>> don't add them to the same bridge instance.
>
> But why should I not be able to add both 4043 and 4044 to the same bridge?

You are able to add them to the same bridge.  Doing so will pass
traffic between them.  That's what a bridge does.  If you don't want
traffic bridged, don't put them in the same bridge.  But you
experienced the expected and desirable behavior corresponding to
adding multiple interfaces to a bridge, and then you come to the list
saying "Doctor, it hurts when I do this."

Linux supports multiple bridge interfaces.  If you want multiple
private networks isolated from each other, use a new bridge instance
for each.  That's what multiple bridge instances are for.  If you want
a server to serve clients in multiple VLANs, make the server listen on
multiple interfaces (these can be VLANs on a single physical link).
That simplifies the MAC address table and cuts down on broadcast
traffic as well.  Then you don't have the complexity of ebtables to
block traffic between ports, every VLAN is fully connected using its
own bridge instance and no traffic crosses to a different VLAN at all.
