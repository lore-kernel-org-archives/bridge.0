Message-ID: <20031103152817.1022.qmail@web13910.mail.yahoo.com>
Date: Mon, 3 Nov 2003 07:28:17 -0800 (PST)
From: Scott MacKay <scottmackay@yahoo.com>
Subject: Re: [Bridge] [RELEASE] ebtables-brnf-3-vs-2.4.22 and ebtables-2-0-6
In-Reply-To: <200311021907.03329.bdschuym@pandora.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>, ebtables-user <ebtables-user@lists.sourceforge.net>, bridge <bridge@osdl.org>

Is there a way to indicate the changes performed for
the userspace mangle bug?  Currently, I am a bit tied
to 2.4.20 until a new round of kernel upgrades are
allowed....

--- Bart De Schuymer <bdschuym@pandora.be> wrote:
> Hi,
> 
> At http://sourceforge.net/projects/ebtables/ you can
> find the following new 
> releases:
> 
> ebtables-brnf-3-vs-2.4.22
> Changes:
> - let iptables see VLAN tagged IP traffic
> - bugfix for queued packets that get mangled in
> userspace
> - ebt_among module (Grzegorz Borowiak)
> - ebt_limit module (Tom Marshall) 
> The patch compiles but I've done no further tests,
> but I probably didn't screw 
> up.
> 
> ebtables-2-0-6 (userspace)
> - ebt_among module (Grzegorz Borowiak)
> - ebt_limit module (Tom Marshall) 
> 
> cheers,
> Bart
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge


__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
