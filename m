From: Bart De Schuymer <bdschuym@pandora.be>
Date: Thu, 11 Sep 2003 20:44:10 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309112044.10635.bdschuym@pandora.be>
Subject: [Bridge] [RELEASE] ebtables-brnf vs 2.4.20 try 2
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://localhost.localdomain/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge <bridge@osdl.org>, ebtables-user <ebtables-user@lists.sourceforge.net>

Hi,

The first patch had the problem that it was twice as long as intended, due to 
a '>>' instead of '>' in my script. I'm sure many of you figured that one out 
:)
You can find the new, again untested, patch here:

http://sourceforge.net/projects/ebtables/

cheers,
Bart

