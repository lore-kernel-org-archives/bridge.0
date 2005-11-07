Message-ID: <436FB61C.7030406@berlin.de>
Date: Mon, 07 Nov 2005 21:16:28 +0100
From: Michael Bueker <m.bueker@berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Simple list of tun devices?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello,

I'm using acustom script to bring up and take down my bridge. For that, 
I need to know the bridge devices that are currently active for use in a 
bash for-loop.
I reckon that I could grep and sed the output of ifconfig or brctl show, 
but that seems very kludgy to me. The tun* devices do not appear in /dev 
and neither did a grep in all of /proc return any useful result.

So, is there a simple way to tell which tun devices are up at any moment?

Cheers,
~Mik

-- 
Was passiert, wenn man einem Therapiepatienten ein asymmetrisches 
Mandala zum Ausmalen gibt? Wird er dann erst recht wahnsinnig?
