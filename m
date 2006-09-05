Date: Tue, 5 Sep 2006 09:30:10 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060905093010.5ac1717b@localhost.localdomain>
In-Reply-To: <20060904153922.22148.qmail@web54303.mail.yahoo.com>
References: <20060904153922.22148.qmail@web54303.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] q-bridge-mib and snmp question
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: pfer <forgamedev@yahoo.com>
Cc: bridge@lists.osdl.org

On Mon, 4 Sep 2006 08:39:22 -0700 (PDT)
pfer <forgamedev@yahoo.com> wrote:

> Hello people!
> 
> Sorry if this is a bit off-topic, but I was not able
> to find a more appropriate mailing list for this.
> 
> I would like to set forwarding rule entries in an
> ethernet switch, with snmp.

Linux bridge doesn't implement SNMP.

And setting entries with SNMP would be a security hole.
One of the reasons (beside laziness) that I haven't even
looked at more management support is that many management
protocols seemed to be designed without security.

> 
> Problem is, it works with the D-link web-manager and
> terminal, but not with snmp.
> 
> I'd be happy if you could point me to a more
> appropriate list too :D
> 
> dot1qStaticUnicastTable stores the per-vlan entries I
> wish to fill (da-mac address, etc), but when I try to
> use something like:
> 
> #snmpset -c private -v2c 10.4.2.102
> .1.3.6.1.2.1.17.7.1.3.1.1.3.4.0.16.90.177.25.152.0 x
> 00004000
> 
> (the 00004000 egress ports for the 4 numbered vlan for
> 
>  the 0.16.90.177.25.152 mac, for all ports (0 at end)
> )
> 
> I get a "non-writeable" error, contrary to what the
> q-brigde-mib rfc says of this entry. (read-write)
> 
> The same value can be read back after it is set with
> other methods, so it shall be working.
> 
> My guess is that I shall set another variable
> somewhere, but I can't find it.
> 
> I use net-snmp, worked for many stuff fine, so the
> problem is not there.
> 
> 
> Any suggestions? Someone tried to set static
> forwarding rules with 802.1q?
> 
> Thanks for help,
> 
> Ferenc Pintér
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge
> 


-- 
Stephen Hemminger <shemminger@osdl.org>
