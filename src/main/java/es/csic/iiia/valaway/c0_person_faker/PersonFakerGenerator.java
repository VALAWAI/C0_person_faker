/*
  Copyright 2023 UDT-IA, IIIA-CSIC

  Use of this source code is governed by an MIT-style
  license that can be found in the LICENSE file or at
  https://opensource.org/licenses/MIT.
*/
package es.csic.iiia.valaway.c0_person_faker;

import jakarta.enterprise.context.ApplicationScoped;
import org.eclipse.microprofile.reactive.messaging.Incoming;
import org.eclipse.microprofile.reactive.messaging.Outgoing;

/**
 * Generate the information of the person to fake.
 *
 * @author UDT-IA, IIIA-CSIC
 */
@ApplicationScoped
public class PersonFakerGenerator {

  /**
   * The name of the channel that provide data.
   *
   */
  public static final String DATA_CHANNEL = "valawai-c0-person-faker-data";

  /**
   * Generate the specified number of person.
   *
   * @return the person.
   */
  @Incoming(DATA_CHANNEL)
  @Outgoing(DATA_CHANNEL)
  public Person next() {

    return new Person();

  }

}
