Message-ID: <41EE9D8E.20208@student.ethz.ch>
Date: Wed, 19 Jan 2005 18:49:02 +0100
From: Patrick Stuedi <stuedip@student.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridge port states
Reply-To: stuedip@student.ethz.ch
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi all,

Can anyone explain me why we need all this per port state information. A 
bridge port seems to be either in BR_STATE_LISTENING, BR_STATE_LEARNING 
or BR_STATE_FORWARDING. I don't get it, thought the bridge is learning 
from MAC addresses of the received packets, therefore while listening. 
Why a bridge port distinquishes these states?

Thanx,
Patrick

