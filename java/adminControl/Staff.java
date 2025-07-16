package adminControl;

import java.sql.Date;

public interface Staff {
	
	int getId();
    String getName();
    String getNic();
    String getPhone();
    String getEmail();
    String getAddress();
    String getDistrict();
    String getProvince();
    Date getBirthday();
    String getGender();
    String getPassword();


}
