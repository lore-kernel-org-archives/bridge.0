From: Joao Carvalho <Joao.Carvalho@fe.up.pt>
Subject: Re: [Bridge] Permanent after reboot
Date: Mon, 15 Mar 2004 08:27:42 +0000
References: <018001c404f2$0ce0c3b0$6400a8c0@Wesley> <405526F4.5040101@cox.net>
In-Reply-To: <405526F4.5040101@cox.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403150827.43103.Joao.Carvalho@fe.up.pt>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

just put it in
/etc/rc.d/rc.local
its simple and it works ;-)
if you even so want to use an System V script
you will have to create the dirs
/etc/rc.d/init.d
/etc/rc.d/rc3.d/
/etc/rc.d/rc5.d/
copy the script to init.d and create the links in rc3 and rc5.
i would recopmend you using the rc.local just invoke your script.
cheers
JC

On Monday 15 March 2004 03:45, Greg Morgan wrote:
> Wesley GDS wrote:
> > Hi there
> >
> > I was just wondering if you could help me.  I have set up a bridge
> > between my two eth cards, works fine.  The problem i have is that when i
> > reboot my PC the bridge is lost.  Is there any way i can make this
> > permanent.
> >
> > I am running slackware 9.1
>
> There are a set of initialization files or init files in Linux.  You
> will need to write a script.  All the steps that you used to create the
> bridge by hand is what will be stored in this script.   The your script
> will need to be called in runlevel 3 and runlevel 5.  This is how Linux
> systems startup.  You may want to search on System V ( as in five )
> startup files.  Each distro puts their startup file in a different
> directory.  On Redhat systems it is in /etc/rc.d but I am not sure if
> this is the same for Slackware.
>
> I hope this helps,
> Greg
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Joao de Deus Carvalho         Phone: +351-225081635      Fax: +351-225081537
Faculdade de Engenharia da            Email: Joao.Carvalho@foxlink.org
Universidade do Porto         
   PGP Key fingerprint = F9D4 EC6A 2BA2 BCD6 0585  1682 891F 156F 8833 E56E
