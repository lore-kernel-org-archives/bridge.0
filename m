Message-ID: <41DAD63B.7010600@phreaker.net>
Date: Wed, 05 Jan 2005 01:45:31 +0800
From: ro0ot <ro0ot@phreaker.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] two transparent (bridging) firewall
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

I am planning to implement the following setup as below: -

                                                    ------- Bridging 
FW-1 -------
Internet ---- Router ---- Hub ---- 
|                                              | ---- Switch ---- 
Servers (VoIP)
                                                    ------- Bridging 
FW-2 -------

I would like to understand how does the Servers (VoIP) behind the two 
Bridging Firewalls will know which path will it choose to route the 
traffic out and which path will it use often.

Hope my question is not off topic.

Thank you,
ro0ot



