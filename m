Message-ID: <ace3f33d05050917531641fb@mail.gmail.com>
Date: Tue, 10 May 2005 06:23:24 +0530
From: srinivas naga vutukuri <srinivas.vutukuri@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Can it possible to call the bridge ioctl calls from
	another module code...
Reply-To: srinivas naga vutukuri <srinivas.vutukuri@gmail.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,

          I am using 2.4.x kernel and the kernel native bridge code
(for bridging).
I am creating Pseudo net_devices'  which should be added to the bridge
interfaces.
without intervention of bridge-utils (ie., brctl) to add interface
from the userland,
can i able to call the br_ioctl (), br_ioctl_deviceless_stub () which
is calling the static br_ioctl_deviceless () function, which is
adding/deleting the interface from the
bridge. But my doubt is they are not defined as static, am thought global scope,
but no where exported those function symbols, so using directly into
another module is correct way of usage?

         Thanks for help in advance.

best regards,
srinivas.

