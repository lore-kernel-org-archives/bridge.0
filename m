From: Dmitry Mishin <dim@openvz.org>
Date: Mon, 30 Oct 2006 15:27:14 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610301527.15018.dim@openvz.org>
Subject: [Bridge] Bridge & it's MAC address question
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: netdev@vger.kernel.org, bridge@osdl.org, devel@openvz.org

Hi,

Could somebody explain, why bridge uses minimal MAC of the attached devices?
It makes this address instable, variable during bridge life-cycle, which is 
not good for DHCP. For example, I want to attach multiple virtual devices to 
one physical. Then, I need to make sure that after each virtual device 
addition, bridge addr is not changed and still addr of the physical device.  
Why not to use MAC of the first attached device?

-- 
Thanks,
Dmitry.
