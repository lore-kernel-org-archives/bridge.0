Return-Path: <stephen@networkplumber.org>
Date: Fri, 20 Mar 2015 14:51:30 -0500
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20150320145130.3253ef6c@uryu.home.lan>
In-Reply-To: <550BABAA.10803@gmail.com>
References: <550BABAA.10803@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge port number changing
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Brett Worth <brett.worth@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Fri, 20 Mar 2015 16:10:02 +1100
Brett Worth <brett.worth@gmail.com> wrote:

> Hi all.  This is my first post to this list and I hope you'll be able to help.
> 
> I have been using the Linux bridge module for a long time under kvm on centos.  This has
> not given me any problems until now.
> 
> I'm adding some host servers and am using HP BL660 blades.
> 
> The kvm nic script in /etc/kvm creates a tap device then assigns a MAC address after
> modifying the first byte to FE.  This is so the port 1 host mac doesn't change.
> 
> On a working host server when running brctl showmacs br0 I see the tap mac address and the
> mac address assigned to the vm on the same port. The tap mac shows as local and the vm mac
> is not.
> 
> The problem:
> 
> Intermittently (once a minute or so) the port number shown for the VM will switch to port
> 1.  During this time the VM cannot be contacted. The tap device mac remains at it's
> original value.  If I wait it will switch back to the correct port number i.e. the one
> associated with the tap device at which point network connectivity is re-established.
> 
> I have looked for the VM mac address on the LAN but cannot see it so it seems to be
> something internal to the bridge.
> 
> Can anyone offer a suggestion as to what might be happening?
> 
> I'm running centos 6.6 and the bridge is 2.3.
> 
> Regards
> Brett
> 

No idea, you might try running 'ip monitor' and put output to a log file.
Something i changing things underneath you. Maybe Network Manager?
