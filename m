In-Reply-To: <m3fxe6trbj.fsf@ursa.amorsen.dk>
References: <OF5294E054.E129AF46-ONC12575D1.0046722C-C12575D1.004A59BC@transmode.se>	<20090610074542.39f713eb@nehalam>
	<OFF985F65C.FBA8694B-ONC12575D1.00546CBF-C12575D1.0055565C@transmode.se>	<20090610162752.GB24563@kallisti.us>
	<OF4422F49E.33BDAF5C-ONC12575D1.005C802A-C12575D1.005E38A3@LocalDomain>	<OF3035BFFB.A9837EFB-ONC12575D2.00451300-C12575D2.00468AB7@transmode.se>
	<m3fxe6trbj.fsf@ursa.amorsen.dk>
Message-ID: <OFFE50FA9A.7AE82F0F-ONC12575D2.007EDC69-C12575D2.007F4D1F@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 12 Jun 2009 01:10:28 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] RFC: Simple Private VLAN impl.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Benny Amorsen <benny+usenet@amorsen.dk>
Cc: Stephen Hemminger <shemminger@vyatta.com>, bridge@lists.linux-foundation.org

Benny Amorsen <benny+usenet@amorsen.dk> wrote on 11/06/2009 23:04:48:
> Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:
>
> >    ---------------------------------------------------------------
> >    |             | isolat-| promis-| commu-| commu-| interswitch |
> >    |             | ted    | cuous  | nity1 | nity2 | link port   |
> >    ---------------------------------------------------------------
> >    | isolated    | deny   | permit | deny  | deny  | permit      |
> >    ---------------------------------------------------------------
> >    | promiscuous | permit | permit | permit| permit| permit      |
> >    ---------------------------------------------------------------
> >    | community1  | deny   | permit | permit| deny  | permit      |
> >    ---------------------------------------------------------------
> >    | community2  | deny   | permit | deny  | permit| permit      |
> >    ---------------------------------------------------------------
> >    | interswitch |        |        |       |       |             |
> >    | link port   | deny(*)| permit | permit| permit| permit      |
> >    ---------------------------------------------------------------
>
> Ok, I thought this would be really easy, but I must admit I don't get
> how an interswitch link port works. Apparently the different VLAN's are
> allowed to go to the same ports, but you can't send a packet back out
> the physical interface it came in on.

Yes that took a while to figure out:
#.4042 = Promisc/Primary VLAN (P)
#.4043 = Isolated VLAN (I)
#.4044 = Community VLAN (C)
#These VLANs represent the interswitch port:
# Promisc ports only TX to P, but RX from P, C & I
# Community ports only TX to C VLAN, but RX from C & P
# Isolated ports only TX to I VLAN, but RX only P

>
> I ignored the community rules, exercise for the reader...

See the latest mail from Ross, I thin he is on to something ..

Also, do we need to do anything if STP is running on the bridge?

