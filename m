Message-ID: <43CBB729.9030007@phreaker.net>
Date: Mon, 16 Jan 2006 23:09:29 +0800
From: ro0ot <ro0ot@phreaker.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] 1 system with 3 bridges 
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi all,

I have one bridge system (used for controlling bandwidth) connected to 
three different DSL ISP provider.  I have the following setup below: -

+-------------+
|   br0             |
|   -> eth1       | -> DSL_1
|   -> eth2       |
+-------------+
|   br1             |
|   -> eth3       | -> DSL_2
|   -> eth4       |
+-------------+
|   br2             |
|   -> eth5       | -> DSL_3
|   -> eth6       |
+-------------+

br0 has eth1 and eth2; br0 has no ip address

br1 has eth3 and eth4; br0 has no ip address

br2 has eth5 and eth6; br0 has no ip address

The traffic of DSL_1 ISP will pass thru br0.  The traffic of DSL_2 ISP 
will pass thru br1.  The traffic of DSL_3 ISP will pass thru br2.

I have a question.  Is it ok I do it as above in 1 system with 3 bridges 
or separate it to 3 system with each system have their own bridge?

Regards,
ro0ot




