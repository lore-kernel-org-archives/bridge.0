Date: Mon, 27 Sep 2004 12:26:40 +0100
From: "John P. Looney" <valen@tuatha.org>
Message-ID: <20040927112640.GB31689@magicbluesmoke.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] linux as a switch
Reply-To: valen@tuatha.org
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

 I've been playing with Linux bridging for a while, in small low-volume
environments as well as with UML, without problems.

 However, I'm looking for something more out of a switch than I can get
currently, and I was wondering if I could configure Linux to be a switch -
bridge over eight or so interfaces efficently.

 Has anyone done this ? What sort of traffic can your average linux box
handle like this ? I'm looking at using it on the NexCom boxes;
    http://www.ipc2u.de/servlet/comp?22785&22752&22780
which have 8 e100 nics and 4 e1000 nics on a 64bit/66Mhz bus. Seems nice,
if it'll work. Then i'd need to make sure that ucd-snmp etc. will let me
get traffic stats per real (not bridged) interface, just like a normal
managed switch.

 I went through the archives of the list, and there seems to be some
problems with VLANs, historically. This would be for use in a very
production environment. I'll do loads of testing, but I'd like to know
any caveats from day one.

John
