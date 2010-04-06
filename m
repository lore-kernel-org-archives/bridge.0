From: "Ryan King" <ryank@globaldial.com>
References: <q2x1803dfd21004061402h67b2a920m4b9b1ac2dc66bb2f@mail.gmail.com>
	<l2sc5b98f841004061617s1bb85838k7c1cc7a887646b53@mail.gmail.com>
In-Reply-To: <l2sc5b98f841004061617s1bb85838k7c1cc7a887646b53@mail.gmail.com>
Date: Wed, 7 Apr 2010 07:57:58 +0800
Message-ID: <000001cad5e4$fcc81030$f6583090$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-au
Subject: Re: [Bridge] Bridging vSwitches in VMwares ESXi
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: 'Robert LeBlanc' <robert@leblancnet.us>, Ryan Whelan <ryan.whelan@tbamerica.com>
Cc: bridge@lists.linux-foundation.org

On Tue, Apr 6, 2010 at 3:02 PM, Ryan Whelan <ryan.whelan@tbamerica.com>
wrote:
>
> I'm having an issue bridging 2 virtual switches in VMwares ESXi. =
=A0I've
made a post on the VMware forums describing the issue
(http://communities.vmware.com/message/1507261#1507261).
> I have searched the internet and found a post
(http://archives.free.net.ph/message/20100108.174704.efbb18cc.ja.html) =
by
someone having the exact same issue- it looks like that post was on this
list?
> In short, I have a Linux VM in ESXi with 2 vNICs- one in each of 2
different vSwitches. =A0A client (in my case a windows machine) on the =
second
vSwitch can't get the MAC address of the default gateway on the first
vSwitch. =A0Sniffing the traffic shows the arp broadcast from the =
windows
machine making if over the linux bridge and getting responded to by the
cisco gateway but the response never makes it back over the bridge.
=A0Watching the mac table in the linux bridge shows it =
mistakenly=A0associates
the mac address of the windows machine to the wrong port (eth0 in my =
case,
eth1 is the vNIC plugged into the switch with the windows box)
> Im not sure where the issue is; its really pretty simple setup. =A0Am =
I
missing something simple? Is there really a bug here?
> Thanks!

You do not wan to bridge in a VMWare environment, it will only drive
you to an early grave. I've blogged my experience with this problem at
http://robert.leblancnet.us/ you will need a google wave account to
view it. In short use proxy arp instead if you can.

Robert LeBlanc
Life Sciences & Undergraduate Education Computer Support
Brigham Young University




I've also had the exact same issues.  However, if I move one of the =
vNICs to
a vSwitch using a different physical nic, then the issue seems to go =
away.

Ryan King


