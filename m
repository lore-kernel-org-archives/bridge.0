Message-ID: <43992197.5010902@innomedia.soft.net>
Date: Fri, 09 Dec 2005 11:47:59 +0530
From: kanhu <kanhu@innomedia.soft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Unable to learn macs on bridge ports
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hi list,

I am using bridge-utils with uClinux having kernel-2.4.19.
All the commands with brctl is working fine except the showmacs.
when i execute the command

/>brctl showmacs test

bridge name     bridge id               STP enabled     interfaces

It does not show any learned mac, So the bride(test) is not functioning 
properly for unicast packets.
Bridging option is already enabled in kernel.

Any help to proceed is welcome

With Thanks & Regards
             Kanhu


