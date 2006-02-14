Message-ID: <34d8b2fe0602140042q68e4c93eleb7be79c83f6da18@mail.gmail.com>
Date: Tue, 14 Feb 2006 09:42:32 +0100
From: Louis Croisez <louis.croisez@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Lost TCP packet
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi,
i am testing two bridges by sending to it random packets using hping2.
First i create a random-length file, then i send it a lot of time on
the wire using this command:
for ($i=0; $i<50000; $i++) {  hping2 -q -c 1 -d $data_len -E
random.file 10.0.0.10  }

My problem is that some packets are lost.
Here is my setup:
               PC1 (10.0.0.1) ===== BR1 --------- BR2 ===== PC2 (10.0.0.10)

After analysis, i determined that these packets were lost because one
of the two bridges was in BR_STATE_DISABLED state when the lost packet
arrived.
In fact, the packet is thrown by the bridge because, in
br_input.c::br_handle_frame(), state==BR_STATE_DISABLED which force
the code to jump to the err: tag at the end of this function.
The state is set to this value while an event is received inside
br_notify.c::br_device_event(), which do a br_stp_disable_port().
After putting some printk in br_notify.c, i remarked that this event
come regularly, and always related to the same bridge port (eth1).
It don't hurt me that this event come regularly, but problem is when a
packet is flowing in the same time thru the bridge, which cause it to
be lost.

I suspect a wrong bridge configuration from me. What i would like to know is:
-  what do i wrong to get this events fired?
-  what should i do to correct this behavior?

Cheers,
Louis.

