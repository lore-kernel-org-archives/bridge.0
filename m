Return-Path: <dennisml@conversis.de>
From: Dennis Jacobfeuerborn <dennisml@conversis.de>
Message-ID: <55DCBB02.6050308@conversis.de>
Date: Tue, 25 Aug 2015 20:59:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Bridge] vlan "aware" bridges
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi,
through the cumulus documentation I learned that there apparently now
exists a way to create a single bridge that allows vlan filtering rather
than the old method using an individual bridge for each vlan.
That documentation only uses this new bridge model in the context of
their new ifupdown2 tool though.

Is there any practical documentation out there or some
tutorials/examples that explain how to use/configure such a vlan aware
bridge using the basic bridge/ip toolset?

Regards,
  Dennis
